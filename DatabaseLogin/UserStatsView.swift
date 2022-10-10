//
//  UserStatsView.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 10.10.2022.
//

import SwiftUI
import SwiftUICharts    

struct UserStatsView: View {
    var data: DoughnutChartData?
    var user: User
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
        
    }
     
}

struct UserStatsView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatsView(data: makeData(grades: [Grade(attendance: false, activity: "0", comments: ""),Grade(attendance: false, activity: "1", comments: ""),Grade(attendance: false, activity: "2", comments: ""),Grade(attendance: false, activity: "3", comments: ""),Grade(attendance: false, activity: "4", comments: "")], user: User(uid: "", email: "", name: "Stepan", lastName: "Kravtsov", isAdmin: false, grade: "10")), user: User(uid: "", email: "", name: "", lastName: "", isAdmin: false, grade: "10"))
    }
}

public func makeData(grades: [Grade], user: User) -> DoughnutChartData {
    var dataPoints: [PieChartDataPoint] = []
    for grade in grades{
        if grade.attendance && grade.activity != ""{
            dataPoints.append(PieChartDataPoint(value: Double(grades.filter { $0.activity == grade.activity}.count), description: grade.activity  , colour: Color.random  , label: .label(text: grade.activity, rFactor: 0.8)))
        }
    }
    let data = PieDataSet(
        dataPoints: dataPoints,
        legendTitle: "Grades")
    
    return DoughnutChartData(dataSets: data,
                             metadata: ChartMetadata(title: "Grade summary", subtitle: "\(user.name) \(user.lastName)"),
                             chartStyle: DoughnutChartStyle(infoBoxPlacement: .header),
                             noDataText: Text("No grades"))
}

