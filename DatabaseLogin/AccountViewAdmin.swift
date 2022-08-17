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
                        NavigationLink(destination: ManageUsersView()){
                            Text("Manage users")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .background(Color.teal)
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
