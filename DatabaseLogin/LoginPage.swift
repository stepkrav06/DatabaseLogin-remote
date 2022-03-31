//
//  LoginPage.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 30.03.2022.
//

import SwiftUI

struct LoginPage: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var name: String = ""
    @State private var lastName: String = ""
    @State private var isAdmin: String = ""
    @FocusState private var writingFocus: Bool
    @State private var createUserAlertError = false
    @State private var createUserAlertSuccess = false
    @State private var logInAlertError = false
    @EnvironmentObject var viewModel: AppViewModel
    @EnvironmentObject var userList: Users
    var body: some View {
        
        ZStack{
            VStack{
                Image(systemName: "person.fill")
                    .font(.system(size: 100))
                VStack {
                    TextField(
                        "Email",
                        text: $email
                    )
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .focused($writingFocus)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    
                    SecureField(
                        "Password",
                        text: $password
                    )
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .focused($writingFocus)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    TextField(
                        "Name",
                        text: $name
                    )
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .focused($writingFocus)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    TextField(
                        "Last name",
                        text: $lastName
                    )
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .focused($writingFocus)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    
                }
                
                
                Button(action: {
                    writingFocus = false
                    guard !email.isEmpty, !password.isEmpty else{
                        return
                    }
                    viewModel.createUser(email: email, password: password, name: name, lastName: lastName, isAdmin: false)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        if viewModel.createUserError != nil {
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
                    Alert(title: Text("Unable to create user"), message: Text(viewModel.createUserError!), dismissButton: .default(Text("OK")) {viewModel.createUserError = nil})
                }
                .alert("User created successfully", isPresented: $createUserAlertSuccess) {
                    Button("OK", role: .cancel) { }
                }
                Spacer()
                Button(action: {
                    writingFocus = false
                    guard !email.isEmpty, !password.isEmpty else{
                        return
                    }
                    //AddUser()
                    
                    viewModel.logIn(email: email, password: password)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        if viewModel.logInError != nil {
                            logInAlertError = true
                        }
                    }
                }){
                    Text("Sign In")
                }
                .foregroundColor(.white)
                .padding()
                .background(.orange)
                .cornerRadius(8)
                .alert(isPresented: $logInAlertError) {
                    Alert(title: Text("Unable to log in"), message: Text(viewModel.logInError!), dismissButton: .default(Text("OK")) {viewModel.logInError = nil})
                }
                Spacer()
//                Button(action: {
//                    AddUser()
//
//                }){
//                    Text("Add user")
//                }
//                .foregroundColor(.white)
//                .padding()
//                .background(.orange)
//                .cornerRadius(8)
//                ForEach(userList.users) { user in
//                    Text(user.name)
//                }
            }
            .navigationTitle("Sign In")
            
            
        }
        
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
