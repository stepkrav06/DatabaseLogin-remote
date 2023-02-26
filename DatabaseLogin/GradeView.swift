//
//  GradeView.swift
//
//  Grading page
//
//

import SwiftUI
import Foundation
import AVFoundation

struct GradeView: View {
    @EnvironmentObject var viewModel: AppViewModel
    var body: some View {
        ScrollView {
            VStack{
                ForEach(viewModel.eventList){event in
                    if viewModel.currentLoggedUser!.isAdmin{
                        // shown for admin users
                        NavigationLink(destination: GradingDetailedAdmin(event: event)){
                            GradeCard(admin: viewModel.currentLoggedUser!.isAdmin, event: event)
                        }
                    } else {
                        // shown for regular users
                        NavigationLink(destination: GradeViewDetailedNonAdmin(event: event)){
                            GradeCard(admin: viewModel.currentLoggedUser!.isAdmin, event: event)
                        }
                    }
                    
                    
                }
            }
        }
        .navigationTitle(viewModel.currentLoggedUser!.isAdmin ? "Grading" : "Activity")
        .toolbar {
            if viewModel.currentLoggedUser!.isAdmin{
                Button(action: {}){
                    NavigationLink(destination: ExportGradesView()){
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(Color.textColor1)
                    }
                }
                Button(action: {}){
                    NavigationLink(destination: StatsPickView()){
                        Image(systemName: "chart.bar")
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
