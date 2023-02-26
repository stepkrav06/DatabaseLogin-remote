//
//  AccountView.swift
//
//  The account page for regular users
//
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State var userRemoveAlert = false
    @State var userRemoveAlertFail = false
    var body: some View {
            
        ScrollView{
                    VStack {
                        Image(systemName: "person.crop.circle")
                            .font(.system(size: 100))
                            .foregroundColor(.textColor1)
                        Text("Hello, " + (viewModel.currentLoggedUser?.name ?? ""))
                        Button(action: {viewModel.logOut()}){
                            Text("Sign out")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .background(Color.teal)
                                .cornerRadius(20)
                        }
                        
                        .padding()
                        
                        
                        Button(action: {
                            if viewModel.currentLoggedUser!.tasks != ["placeholder"]{
                                userRemoveAlertFail.toggle()
                            } else {
                                userRemoveAlert.toggle()
                            }
                        }){
                            Text("Delete account")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .background(Color.red)
                                .cornerRadius(20)
                        }
                        .alert("Are you sure you want to remove this account? This action can't be undone.", isPresented: $userRemoveAlert) {
                            Button("Cancel", role: .cancel) { }
                            Button("Yes", role: .destructive) {viewModel.deleteUser(user: viewModel.currentLoggedUser!) }
                        }
                        .alert("There are still tasks assigned to this user. You need to delete the assigned tasks before you delete the user", isPresented: $userRemoveAlertFail) {
                            Button("Cancel", role: .cancel) { }
                        }
                        
                        .padding()
                        
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
