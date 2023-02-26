//
//  AccountViewNonAdmin.swift
//
//  The account page for regular users
//
//

import SwiftUI

struct AccountViewNonAdmin: View {
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                
                AccountView()
                    .frame(maxWidth: geometry.size.width)
            }
            .frame(maxWidth: geometry.size.width)
                    .navigationTitle("Account")
        }
    }
}

struct AccountViewNonAdmin_Previews: PreviewProvider {
    static var previews: some View {
        AccountViewNonAdmin()
    }
}
