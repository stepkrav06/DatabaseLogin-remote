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
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("bg1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.frame(in: .global).width, height: geometry.frame(in: .global).height)
                
                BlurView(effect: .systemUltraThinMaterialDark)
                
                    VStack {
                        Spacer()
                            .frame(maxHeight: 150)
                        Image(systemName: "person.crop.circle")
                            .font(.system(size: 100))
                        Button(action: {viewModel.logOut()}){
                            Text("Sign out")
                        }
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(Color.black
                                        .opacity(0.7)
                        )
                        .cornerRadius(8)
                        if !show{
                            VStack{
                                Text("Change password")
                                    
                                    .matchedGeometryEffect(id: "title", in: namespace)
                                    
                                
                                }
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(Color.black
                                        .opacity(0.7)
                                        .matchedGeometryEffect(id: "bg", in: namespace)
                                        .onTapGesture {
                                            withAnimation(.spring(response: 0.2, dampingFraction: 0.7)){show.toggle()}
                                        })
                        .cornerRadius(8)
                        
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
                                .padding()
                                
                                
                                SecureField(
                                    "Confirm new password",
                                    text: $password2
                                )
                                .textInputAutocapitalization(.never)
                                .disableAutocorrection(true)
                                .padding()
                                
                                
                                Button(action: {}){ //change password
                                Text("Change")
                                        .foregroundColor(.black)
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(8)
                                        
                            }
                                }
                            .textFieldStyle(.roundedBorder)
                                
                            
                            
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: 300)
                        .background(Color.black
                                        .opacity(0.7)
                                        .matchedGeometryEffect(id: "bg", in: namespace)
                                        .onTapGesture {
                                            withAnimation(.spring(response: 0.2, dampingFraction: 0.7)){show.toggle()}
                                        })
                        .cornerRadius(8)
                        
                        }
                        Spacer()
                    }
                    .frame(alignment: .top)
                    .navigationTitle("Account")
                
                
                
            }
        }.ignoresSafeArea()
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
