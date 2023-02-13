//
//  AccountViewNonAdmin.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 05.04.2022.
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
