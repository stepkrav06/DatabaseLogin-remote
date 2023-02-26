//
//  UserStatsView.swift
//
//  The view showing the statistics for a user
//
//

import SwiftUI
import SwiftUICharts    

struct UserStatsView: View {
    @EnvironmentObject var viewModel: AppViewModel
    var data: DoughnutChartData?
    var grades: [Grade]
    var user: User
    @State var hasData: Bool = true
    
    var body: some View {
        ScrollView {
            VStack {
                if !data!.dataSets.dataPoints.isEmpty{
                    // shown of there are grades for the user
                    DoughnutChart(chartData: data!)
                        .touchOverlay(chartData: data!)
                        .headerBox(chartData: data!)
                        .legends(chartData: data!, columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())])
                        .frame(minWidth: 150, maxWidth: 900, minHeight: 150, idealHeight: 500, maxHeight: 600, alignment: .center)
                        .id(data!.id)
                        .padding(.horizontal, 32)
                    VStack{
                        Text("The student has participated in \(data!.dataSets.dataPoints.count) events.")
                            .bold()
                            .padding()
                        Text("The average grade for this student is \(String(format: "%.1f", avg(grades: grades)))")
                            .bold()
                            .padding()
                    }
                    .background{
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .stroke(lineWidth: 2)
                    }
                    .padding(.vertical)
                }
                else{
                    // shown of there are no grades for the user
                    Text("No data")
                }
                
                
            }
        }
        .navigationTitle("Statistics")
        .toolbar {
            
            Button(action: {}){
                NavigationLink(destination: ShareLoading(users: [user: true], events: Dictionary(uniqueKeysWithValues: viewModel.eventList.map{ ($0, true) }))){
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(Color.textColor1)
                }
            }
        }
        
    }
    func avg(grades: [Grade])->Double{
        var sum = 0
        var count = 0
        for grade in grades{
            if grade.activity != "" && grade.attendance == true{
                count+=1
                sum = sum + Int(grade.activity)!
            }
        }
        let res = Double(sum)/Double(count)
        return res
    }
    
     
}





