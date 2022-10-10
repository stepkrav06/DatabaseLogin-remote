//
//  EventStatsView.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 10.10.2022.
//

import SwiftUI
import SwiftUICharts

struct EventStatsView: View {
    var data: DoughnutChartData?
    var event: Event
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
                }
                else{
                    Text("No data")
                }
                
                
            }
        }
        .navigationTitle("Statistics")
        
    }
     
}


