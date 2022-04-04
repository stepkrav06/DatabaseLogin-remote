//
//  AccountViewAdmin.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 04.04.2022.
//

import SwiftUI

struct AccountViewAdmin: View {
    @EnvironmentObject var viewModel: AppViewModel
    @Namespace var namespace
    @State var showChangePassword = false
    @State var showManageUsers = false
    @State private var password: String = ""
    @State private var password2: String = ""
    @FocusState private var writingFocus: Bool
    @State private var changePasswordAlertError = false
    var body: some View {
        
        ScrollView{
                    VStack {
                        AccountView()
                        if !showManageUsers{
                            VStack{
                                Text("Manage users")
                                    
                                    .matchedGeometryEffect(id: "title", in: namespace)
                                    
                                
                                }
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(gradient1
                                        .matchedGeometryEffect(id: "bg", in: namespace)
                                        .onTapGesture {
                                            withAnimation(.spring(response: 0.2, dampingFraction: 0.7)){
                                                showManageUsers.toggle()
                                                viewModel.isWriting.toggle()
                                            }
                                        })
                        .cornerRadius(20)
                        .padding()
                        
                        
                        } else {
                                VStack{
                                    Text("Manage users")
                                        .frame(alignment: .top)
                                        
                                        .matchedGeometryEffect(id: "title", in: namespace)
                                        
                                    ForEach(viewModel.userList){ user in
                                        ManageUserCard(user: user)
                                    }
                                    NavigationLink(destination: AddUserPage()){
                                        Image(systemName: "plus")
                                            .font(.system(size: 30))
                                            .padding(8)
                                            .foregroundColor(.white)
                                            .background(.black)
                                            .mask{
                                                Circle()
                                            }
                                    }
                                    .padding()
                                    }
                                
                            
                            
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(gradient1
                                        .matchedGeometryEffect(id: "bg", in: namespace)
                                        .onTapGesture {
                                            withAnimation(.spring(response: 0.2, dampingFraction: 0.7)){
                                                showManageUsers.toggle()
                                                viewModel.isWriting.toggle()
                                            }
                                        })
                        .cornerRadius(20)
                        .padding()
                        
                        }
                        Spacer()
                    }
                    
                    .frame(alignment: .top)
                    .navigationTitle("Account")
                    
                    
                    .ignoresSafeArea()
                    .background(.background)
        }
                
                
            
            
        
    }
}

struct AccountViewAdmin_Previews: PreviewProvider {
    static var previews: some View {
        AccountViewAdmin()
    }
}
