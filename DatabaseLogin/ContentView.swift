//
//  ContentView.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 29.03.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var createUserAlert = false
    var body: some View {
        ZStack{
            VStack{
                TextField(
                        "Email",
                        text: $email
                    )
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                
                TextField(
                        "Password",
                        text: $password
                    )
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                
                Button(action: {
                    if createUser(email: email, password: password) != nil {
                        createUserAlert = true
                    }
                    
                }){
                    Text("Add user")
                }
                .alert(isPresented: $createUserAlert) {
                            Alert(title: Text("Unable to create user"), message: Text("bububu"), dismissButton: .default(Text("OK")))
                        }
                
                Button(action: {createUserAlert = true}){
                    Text("Log in")
                }
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
