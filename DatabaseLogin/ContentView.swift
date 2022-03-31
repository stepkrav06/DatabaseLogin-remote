//
//  ContentView.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 29.03.2022.
//

import SwiftUI
import Firebase

class AppViewModel: ObservableObject {
    
    @Published var createUserError: String?
    @Published var logInError: String?
    @Published var signedIn: Bool = false
    @Published var currentLoggedUser: User? = nil
    
    var isSignedIn: Bool  {
        return Auth.auth().currentUser != nil
    }
    func createUser(email: String, password: String, name: String, lastName: String, isAdmin: Bool) {
        
        Auth.auth().createUser(withEmail: email, password: password) { res, error in
            if error != nil {
                self.createUserError = error?.localizedDescription ?? ""
                print(self.createUserError!)
            } else {
                let user = User(uid: res!.user.uid, email: email, name: name, lastName: lastName, isAdmin: isAdmin)
                let ref = Database.database().reference(withPath: "users")
                let userRef = ref.child(res!.user.uid)
                userRef.setValue(user.toAnyObject())
            }
            
        }
    }
    func logIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { user, error in

            guard user != nil, error == nil else {
                self.logInError = error!.localizedDescription
                print(self.logInError!)
                return
            }
            DispatchQueue.main.async {
                //Success
                self.signedIn = true
            }
            let ref = Database.database().reference(withPath: "users")
            let userPath = ref.child(user!.user.uid)
//            userPath.getData(completion: { error, snapshot in
//                    guard error == nil else {
//                        print(error!.localizedDescription)
//                        return
//                        
//                    }
                userPath.observe(.value) { snapshot in
                    let curuser = User(snapshot: snapshot)
                    self.currentLoggedUser = curuser
                    print(self.currentLoggedUser)
                    print(curuser)
                } withCancel: { error in
                    print(error.localizedDescription)
                }

                
                
               
                        
                        
                    
                   
                    
                    
                   // })
                
            
            
        }
    }
    func logOut(){
        try? Auth.auth().signOut()
        
        self.signedIn = false
    }
}
class Users: ObservableObject {
    @Published var users: [User] = []
}

struct ContentView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @EnvironmentObject var userList: Users
    var body: some View {
        NavigationView{
            if viewModel.signedIn {
                TabViewAdmin()
            } else {
                LoginPage().onAppear{
                    let ref = Database.database().reference(withPath: "users")
                    let completed = ref.observe(.value) { snapshot in
                      // 2
                      var users: [User] = []
                      // 3
                      for child in snapshot.children {
                        // 4
                          if
                            let snapshot = child as? DataSnapshot,
                          let user = User(snapshot: snapshot) {
                            users.append(user)
                        }
                      }
                        userList.users = users
                        
                        for user in users {
                            print(user.name)
                            print(user.tasks)
                        }
                        
                    }
                    // 6
                    refObservers.append(completed)
                }
            }
            
        }
        .onAppear{
            viewModel.signedIn = viewModel.isSignedIn
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
