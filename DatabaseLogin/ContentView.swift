//
//  ContentView.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 29.03.2022.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView{
            if viewModel.signedIn {
                if viewModel.currentLoggedUser != nil && viewModel.userList != [] {
                    if viewModel.currentLoggedUser?.isAdmin == true{
                        TabViewAdmin()
                    }
                    else{
                        TabViewNonAdmin()
                    }
                    
                }
                else{
                    LoadingView()
                        .onAppear{
                            var ref = Database.database().reference(withPath: "users")
                            let user = Auth.auth().currentUser
                            
                            let userPath = ref.child(user!.uid)
                            userPath.observe(.value) { snapshot in
                                    let curuser = User(snapshot: snapshot)
                                    viewModel.currentLoggedUser = curuser
                                    
                                } withCancel: { error in
                                    print(error.localizedDescription)
                                }
                            ref.observe(.value) { snapshot in
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
                                viewModel.userList = users
                                

                                viewModel.isWriting = false
                            }
                                
                            ref = Database.database().reference(withPath: "events")
                            ref.observe(.value) { snapshot in
                              // 2
                              var events: [Event] = []
                              // 3
                              for child in snapshot.children {
                                // 4
                                  if
                                    let snapshot = child as? DataSnapshot,
                                  let event = Event(snapshot: snapshot) {
                                    events.append(event)
                                }
                              }
                                viewModel.eventList = events
                                
                            }
                            
                        
                }
                
                }
                
            } else {
                LoginPage()
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
