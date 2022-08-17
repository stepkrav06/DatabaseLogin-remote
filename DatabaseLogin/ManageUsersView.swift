//
//  ManageUsersView.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 17.08.2022.
//

import SwiftUI

struct ManageUsersView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    @State var userForDelete: User = User(uid: "", email: "", name: "", lastName: "", isAdmin: false, grade: "")
    var body: some View {
        List{
            ForEach(viewModel.userList, id: \.self){user in
                HStack{
                    Image(systemName: "person.fill")
                        .font(.title)
                    VStack(alignment: .leading){
                        Text(user.name + " " + user.lastName)
                            .fontWeight(.thin)
                        if Int(user.grade) != nil{
                            Text("Grade \(user.grade)")
                                .fontWeight(.thin)
                        } else {
                            Text("Staff")
                                .fontWeight(.thin)
                        }
                        Text("Email: \(user.email)")
                            .fontWeight(.thin)
                    }
                    
                }
                
            }
            
        }
        
        .navigationTitle("Manage users")
        .toolbar{
            NavigationLink(destination: AddUserPage()){
                Image(systemName: "plus")
            }
        }
    }
    
}

struct ManageUsersView_Previews: PreviewProvider {
    static var previews: some View {
        ManageUsersView()
    }
}
