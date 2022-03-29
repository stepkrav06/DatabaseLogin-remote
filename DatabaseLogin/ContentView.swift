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
    @FocusState private var writingFocus: Bool
    @State private var createUserAlertError = false
    @State private var createUserAlertSuccess = false
    @State private var logInAlertError = false
    var body: some View {
        ZStack{
            VStack{
                TextField(
                        "Email",
                        text: $email
                    )
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .focused($writingFocus)
                TextField(
                        "Password",
                        text: $password
                    )
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .focused($writingFocus)

                
                Button(action: {
                    writingFocus = false
                    createUser(email: email, password: password)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        if createUserError != nil {
                            createUserAlertError = true
                        }
                        else {
                            createUserAlertSuccess = true
                        }
                        }
                    
                    
                }){
                    Text("Add user")
                }
                .foregroundColor(.white)
                    .padding()
                    .background(.orange)
                    .cornerRadius(8)
                .alert(isPresented: $createUserAlertError) {
                    Alert(title: Text("Unable to create user"), message: Text(createUserError!), dismissButton: .default(Text("OK")) {createUserError = nil})
                        }
                .alert("User created successfully", isPresented: $createUserAlertSuccess) {
                            Button("OK", role: .cancel) { }
                        }
                Spacer()
                Button(action: {
                    writingFocus = false
                    logIn(email: email, password: password)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if logInError != nil {
                        logInAlertError = true
                    }
                    }
                }){
                    Text("Log in")
                }
                .foregroundColor(.white)
                    .padding()
                    .background(.orange)
                    .cornerRadius(8)
                .alert(isPresented: $logInAlertError) {
                    Alert(title: Text("Unable to log in"), message: Text(logInError!), dismissButton: .default(Text("OK")) {logInError = nil})
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
