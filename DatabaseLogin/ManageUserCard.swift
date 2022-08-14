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
        VStack(spacing: 5){
            HStack{
                Text(user.name)
                    .bold()
                Text(user.lastName)
                    .bold()
            }
            .frame(alignment: .topLeading)
            
            if user.isAdmin {
                Text("Adiminstrator")
                    
            }
            else {
                Text("Non Administaror")
                    
            }
            Text("Email: \(user.email)")
            if Int(user.grade) != nil{
                Text("Grade " + user.grade)
            } else {
                Text(user.grade)
            }
                
        }
        .padding()
        .frame(maxHeight: 120)
        .foregroundColor(.white)
        .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous).stroke(.white, lineWidth: 1))
        .cornerRadius(20)
        .padding()
        
    }
}

struct ManageUserCard_Previews: PreviewProvider {
    static var previews: some View {
        ManageUserCard(user: User(uid: "preview", email: "preview", name: "preview", lastName: "preview", isAdmin: true, grade: "11")).background(.black)
    }
}
