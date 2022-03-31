//
//  SomeView.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 30.03.2022.
//

import SwiftUI

struct SomeView: View {
    @EnvironmentObject var viewModel: AppViewModel
    var body: some View {
        
        VStack {
            Button(action: {viewModel.logOut()}){
                Text("Sign out")
            }
            .foregroundColor(.white)
            .padding()
            .background(.orange)
        .cornerRadius(8)
            //Text(viewModel.currentLoggedUser!.name)
            Button(action: {print(viewModel.currentLoggedUser!)}){
                Text("print")
            }
            .foregroundColor(.white)
            .padding()
            .background(.orange)
            .cornerRadius(8)
        }.navigationTitle("Some view")
    }
}

struct SomeView_Previews: PreviewProvider {
    static var previews: some View {
        SomeView()
    }
}
