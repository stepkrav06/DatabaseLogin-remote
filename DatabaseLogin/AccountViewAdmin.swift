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
        GeometryReader{ geometry in
        ZStack{
            BackgoundView()
                
            ScrollView{
                
                    VStack {
                        AccountView()
                            .frame(maxWidth: geometry.size.width)
                        if !showManageUsers{
                            VStack{
                                Text("Manage users")
                                    
                                    .matchedGeometryEffect(id: "title", in: namespace)
                                    
                                
                                }
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: geometry.size.width, maxHeight: 50)
                        .background(Color.darkGr1
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
                        .frame(maxWidth: geometry.size.width, maxHeight: .infinity)
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
                    
                    
                    
                    
            }
            .frame(maxHeight:.infinity)
        }
        .frame(maxWidth: geometry.size.width)
                .navigationTitle("Account")
        }
                
            
            
        
    }
}

struct AccountViewAdmin_Previews: PreviewProvider {
    static var previews: some View {
        AccountViewAdmin()
    }
}
