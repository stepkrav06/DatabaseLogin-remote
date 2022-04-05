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
                    .bold()
                Text(user.lastName)
                    .bold()
            }
            .frame(alignment: .topLeading)
            .padding()
            if user.isAdmin {
                Text("Adiminstrator")
                    .padding()
            }
            else {
                Text("Non Administaror")
                    .padding()
            }
            Text("Email: \(user.email)")
                .padding()
        }
        .foregroundColor(.white)
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .padding()
        
    }
}

struct ManageUserCard_Previews: PreviewProvider {
    static var previews: some View {
        ManageUserCard(user: User(uid: "preview", email: "preview", name: "preview", lastName: "preview", isAdmin: true))
    }
}
