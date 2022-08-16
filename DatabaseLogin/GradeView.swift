//
//  GradeView.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 14.08.2022.
//

import SwiftUI
import Foundation

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
        .toolbar {
            if viewModel.currentLoggedUser!.isAdmin{
                Button(action: {}){
                    NavigationLink(destination: ExportGradesView()){
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(Color.textColor1)
                    }
                }
                
                
            }
            
        }
        .onAppear{
            viewModel.gradesExported = false
        }
        
    }
    
}

struct GradeView_Previews: PreviewProvider {
    static var previews: some View {
        GradeView()
    }
}
