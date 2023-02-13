//
//  EventStatsView.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 10.10.2022.
//

import SwiftUI
import SwiftUICharts

struct EventStatsView: View {
    @EnvironmentObject var viewModel: AppViewModel
    var data: DoughnutChartData?
    var event: Event
    var grades: [Grade]
    @State var hasData: Bool = true
    
    var body: some View {
        ScrollView {
            VStack {
                if !data!.dataSets.dataPoints.isEmpty{
                    DoughnutChart(chartData: data!)
                        .touchOverlay(chartData: data!)
                        .headerBox(chartData: data!)
                        .legends(chartData: data!, columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())])
                        .frame(minWidth: 150, maxWidth: 900, minHeight: 150, idealHeight: 500, maxHeight: 600, alignment: .center)
                        .id(data!.id)
                        .padding(.horizontal, 32)
                    VStack{
                        Text("\(data!.dataSets.dataPoints.count) students have participated in this event.")
                            .bold()
                            .padding()
                        Text("The average grade for this event is \(String(format: "%.1f", avg(grades: grades)))")
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
                    Text("No data")
                }
                
                
            }
        }
        .navigationTitle("Statistics")
        .toolbar {
            
            Button(action: {}){
                NavigationLink(destination: ShareLoading(users: Dictionary(uniqueKeysWithValues: viewModel.userList.map{ ($0, true) }), events: [event:true] )){
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
            if grade.activity != ""{
                count+=1
                sum = sum + Int(grade.activity)!
            }
        }
        let res = Double(sum)/Double(count)
        return res
    }
     
}


