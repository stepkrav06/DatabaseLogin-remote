//
//  AccountView.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 31.03.2022.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var viewModel: AppViewModel
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
                
            .cornerRadius(8)
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
