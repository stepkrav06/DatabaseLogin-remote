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
    var isSignedIn: Bool  {
        return Auth.auth().currentUser != nil
    }
    func createUser(email: String, password: String) {
        
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if error != nil {
                self.createUserError = error?.localizedDescription ?? ""
                print(self.createUserError!)
            } else {
                
            }
            
        }
    }
    func logIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in

            guard user != nil, error == nil else {
                self?.logInError = error!.localizedDescription
                print(self?.logInError!)
                return
            }
            DispatchQueue.main.async {
                //Success
                self?.signedIn = true
            }
            
        }
    }
    func logOut(){
        try? Auth.auth().signOut()
        
        self.signedIn = false
    }
}

struct ContentView: View {
    @EnvironmentObject var viewModel: AppViewModel
    var body: some View {
        NavigationView{
            if viewModel.signedIn {
                SomeView()
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
                        //self.itemList = newItems
                        
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
