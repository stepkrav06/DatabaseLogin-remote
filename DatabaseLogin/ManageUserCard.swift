//
//  ManageUserCard.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 04.04.2022.
//

import SwiftUI

struct ManageUserCard: View {
    var user: User
    var body: some View {
        VStack{
            HStack{
                Text(user.name)
                Text(user.lastName)
            }
            .frame(alignment: .topLeading)
            .padding(8)
            if user.isAdmin {
                Text("Adiminstrator")
                    .padding(8)
            }
            else {
                Text("Non Administaror")
                    .padding(8)
            }
            Text("Email: \(user.email)")
                .padding(8)
        }
        .foregroundColor(.white)
        .background(.black)
        .cornerRadius(20)
        .padding()
        
    }
}

struct ManageUserCard_Previews: PreviewProvider {
    static var previews: some View {
        ManageUserCard(user: User(uid: "preview", email: "preview", name: "preview", lastName: "preview", isAdmin: true))
    }
}
