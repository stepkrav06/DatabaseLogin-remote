//
//  LoginPage.swift
//
//  Login page
//
//

import SwiftUI

struct LoginPage: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @FocusState private var writingFocus: Bool
    @State private var logInAlertError = false
    
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
                    
                    
                }
                
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
                .background(.teal)
                .cornerRadius(8)
                .alert(isPresented: $logInAlertError) {
                    Alert(title: Text("Unable to log in"), message: Text(viewModel.logInError!), dismissButton: .default(Text("OK")) {viewModel.logInError = nil})
                }
                Spacer()

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
