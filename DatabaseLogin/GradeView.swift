//
//  GradeView.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 14.08.2022.
//

import SwiftUI

struct GradeView: View {
    @EnvironmentObject var viewModel: AppViewModel
    var body: some View {
        ScrollView {
            VStack{
                ForEach(viewModel.eventList){event in
                    NavigationLink(destination: GradingDetailedAdmin(event: event)){
                        GradeCard(admin: viewModel.currentLoggedUser!.isAdmin, event: event)
                    }
                }
            }
        }
        .navigationTitle("Grading")
        
    }
}

struct GradeView_Previews: PreviewProvider {
    static var previews: some View {
        GradeView()
    }
}
