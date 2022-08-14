//
//  AccountView.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 31.03.2022.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @Namespace var namespace
    @State var show = false
    @State private var password: String = ""
    @State private var password2: String = ""
    @FocusState private var writingFocus: Bool
    @State private var changePasswordAlertError = false
    var body: some View {
            
        ScrollView{
                    VStack {
                        Image(systemName: "person.crop.circle")
                            .font(.system(size: 100))
                            .foregroundColor(.textColor1)
                        Text("Hello, " + (viewModel.currentLoggedUser?.name)!)
                        Button(action: {viewModel.logOut()}){
                            Text("Sign out")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .background(Color.teal)
                                .cornerRadius(20)
                        }
                        
                        .padding()
                        if !show{
                            VStack{
                                Text("Change password")
                                    
                                    .matchedGeometryEffect(id: "title", in: namespace)
                                    
                                
                                }
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(Color.teal
                                        .matchedGeometryEffect(id: "bg", in: namespace)
                                        .onTapGesture {
                                            withAnimation(.spring(response: 0.2, dampingFraction: 0.7)){
                                                show.toggle()
                                                viewModel.isWriting.toggle()
                                            }
                                        })
                        .cornerRadius(20)
                        .padding()
                        
                        
                        } else {
                                VStack{
                                    Text("Change password")
                                        .frame(alignment: .top)
                                        
                                        .matchedGeometryEffect(id: "title", in: namespace)
                                        
                                    SecureField(
                                        "New Password",
                                        text: $password
                                    )
                                    .textInputAutocapitalization(.never)
                                    .disableAutocorrection(true)
                                    .focused($writingFocus)
                                    .foregroundColor(.textColor1)
                                    .padding()
                                    
                                    
                                    SecureField(
                                        "Confirm new password",
                                        text: $password2
                                    )
                                    .textInputAutocapitalization(.never)
                                    .disableAutocorrection(true)
                                    .focused($writingFocus)
                                    .foregroundColor(.textColor1)
                                    .padding()
                                    
                                    
                                    Button(action: {
                                        viewModel.changePassword(password: password, confirmPassword: password2)
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            if viewModel.changePasswordError != nil {
                                                changePasswordAlertError = true
                                            }
                                        
                                        }
                                    }){ //change password
                                    Text("Change")
                                            .foregroundColor(.black)
                                            .padding()
                                            .background(Color.white)
                                            .cornerRadius(8)
                                            
                                }
                                    .alert(isPresented: $changePasswordAlertError) {
                                        Alert(title: Text("Unable to change password"), message: Text(viewModel.changePasswordError!), dismissButton: .default(Text("OK")) {viewModel.changePasswordError = nil})
                                    }
                                    }
                            .textFieldStyle(.roundedBorder)
                                
                            
                            
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: 300)
                        .background(Color.teal
                                        .matchedGeometryEffect(id: "bg", in: namespace)
                                        .onTapGesture {
                                            withAnimation(.spring(response: 0.2, dampingFraction: 0.7)){
                                                show.toggle()
                                                viewModel.isWriting.toggle()
                                            }
                                        })
                        .cornerRadius(20)
                        .padding()
                        
                        }
                        
                    }
                    
                    .frame(alignment: .top)
                    .navigationTitle("Account")
                    
                    
                    .ignoresSafeArea()
                    .background(.background)
        }
                
                
            
            
        
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
