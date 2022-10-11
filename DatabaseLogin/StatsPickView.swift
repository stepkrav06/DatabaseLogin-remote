//
//  StatsPickView.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 10.10.2022.
//

import SwiftUI
import SwiftUICharts
import Firebase

struct StatsPickView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State var data: Any = []
    @State var grades: [Grade] = []
    @State var pickedUser: Bool = false
    @State var pickedEvent: Bool = false
    var body: some View {
        
            
                ScrollView {
                    VStack{
                        VStack{
                    Text("Events")
                        .font(.title)
                        .fontWeight(.thin)
                    ForEach(viewModel.eventList){event in
                        Button(action: {
                            for user in viewModel.userList{
                                let ref = Database.database().reference(withPath: "grades").child(user.uid).child(event.sid)
                                ref.observeSingleEvent(of: .value, with: { snapshot in
                                        
                                    let grade = Grade(snapshot: snapshot)
                                    grades.append(grade!)

                                    
                                    }) { (error) in
                                        print(error.localizedDescription)
                                    }
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                data = makeDataEvent(grades: grades, event: event)
                                pickedEvent = true
                            }
                            
                            
                            
                        }){
                            ZStack {

                                NavigationLink(destination: EventStatsView(data: data as? DoughnutChartData ?? nil, event: event, grades: grades), isActive: self.$pickedEvent){
                                    
                                    
                                }.hidden()
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .stroke(Color.textColor1)
                                    .frame(height: 50)
                                    .padding(8)
                                HStack{
                                    Text(event.name)
                                        .foregroundColor(Color.textColor1)
                                }
                            }
                        }
                        
                    }
                }
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding()
                Spacer()
                
                    VStack{
                        Text("People")
                            .font(.title)
                            .fontWeight(.thin)
                        ForEach(viewModel.userList){user in
                            Button(action: {
                                for event in viewModel.eventList{
                                    let ref = Database.database().reference(withPath: "grades").child(user.uid).child(event.sid)
                                    ref.observeSingleEvent(of: .value, with: { snapshot in
                                            
                                        let grade = Grade(snapshot: snapshot)
                                        grades.append(grade!)

                                        
                                        }) { (error) in
                                            print(error.localizedDescription)
                                        }
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    data = makeDataUser(grades: grades, user: user)
                                    pickedUser = true
                                }
                                
                                
                                
                            }){
                                ZStack {

                                    NavigationLink(destination: UserStatsView(data: data as? DoughnutChartData ?? nil, grades: grades, user: user), isActive: self.$pickedUser){
                                        
                                        
                                    }.hidden()
                                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                                        .stroke(Color.textColor1)
                                        .frame(height: 50)
                                        .padding(8)
                                    HStack{
                                        Text(user.name + " " + user.lastName)
                                            .foregroundColor(Color.textColor1)
                                    }
                                }
                            }
                            
                        }
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding()
                    }
                }
                .onAppear{
                    grades = []
                }
        
            
        
        .navigationTitle("Grade statistics")
            
            
    
    }
}

struct StatsPickView_Previews: PreviewProvider {
    static var previews: some View {
        StatsPickView()
    }
}

public func makeDataUser(grades: [Grade], user: User) -> DoughnutChartData {
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

public func makeDataEvent(grades: [Grade], event: Event) -> DoughnutChartData {
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
                             metadata: ChartMetadata(title: "Grade summary", subtitle: "\(event.name)"),
                             chartStyle: DoughnutChartStyle(infoBoxPlacement: .header),
                             noDataText: Text("No grades"))
}
