//
//  AddUserPage.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 04.04.2022.
//

import SwiftUI

struct AddUserPage: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var name: String = ""
    @State private var lastName: String = ""
    @State private var grade: String = ""
    @State private var isAdmin: Bool = false
    @FocusState private var writingFocus: Bool
    @State private var createUserAlertError = false
    @State private var createUserAlertSuccess = false
    
    @EnvironmentObject var viewModel: AppViewModel
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
                    TextField(
                        "Grade",
                        text: $grade
                    )
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .focused($writingFocus)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    Toggle("Admin", isOn: $isAdmin)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    
                }
                
                
                Button(action: {
                    writingFocus = false
                    guard !email.isEmpty, !password.isEmpty, !lastName.isEmpty, !name.isEmpty else{
                        return
                    }
                    viewModel.createUser(email: email, password: password, name: name, lastName: lastName, isAdmin: isAdmin, grade: grade)
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
                .background(.teal)
                .cornerRadius(12)
                .alert(isPresented: $createUserAlertError) {
                    Alert(title: Text("Unable to create user"), message: Text(viewModel.createUserError!), dismissButton: .default(Text("OK")) {viewModel.createUserError = nil})
                }
                .alert("User created successfully", isPresented: $createUserAlertSuccess) {
                    Button("OK", role: .cancel) { }
                }
                Spacer()
                
                Spacer()
            }
            .navigationTitle("Add user")
            
            
        }
        
    }
}

struct AddUserPage_Previews: PreviewProvider {
    static var previews: some View {
        AddUserPage()
    }
}
