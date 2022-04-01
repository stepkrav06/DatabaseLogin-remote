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
        ScrollView {
            VStack {
                Image(systemName: "person.crop.circle")
                    .font(.system(size: 100))
                Button(action: {viewModel.logOut()}){
                    Text("Sign out")
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(.orange)
                if !show{
                    Button(action: {withAnimation{show.toggle()}}){ //change password
                    Text("Change password")
                            
                            .matchedGeometryEffect(id: "title", in: namespace)
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(Color.orange.matchedGeometryEffect(id: "bg", in: namespace))
                .cornerRadius(8)
                
                } else {
                    
                    Button(action: {withAnimation{show.toggle()}}){ //change password
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
                    .background(Color(.secondarySystemBackground))
                    SecureField(
                        "Confirm new password",
                        text: $password2
                    )
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    }
                    
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 300)
                .background(Color.orange.matchedGeometryEffect(id: "bg", in: namespace))
                .cornerRadius(8)
                
                }
                
            }
        }
        .navigationTitle("Account")
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
