//
//  EventViewDetailedAdmin.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 08.04.2022.
//

import SwiftUI
import Firebase

struct EventViewDetailedAdmin: View {
    @EnvironmentObject var viewModel: AppViewModel
    @EnvironmentObject var eventTasks: EventTasks
    @State var showAddTasks: Bool = false
    var event: Event
    @State var tasks: [Task] = []
    var body: some View {
        VStack{
            EventViewDetailed(event: event)
            Button(action: {showAddTasks.toggle()}){
                Text("add tasks")
            }
            .sheet(isPresented: $showAddTasks){
                AddTaskView(event: event)
            }
        }
        
    }
}

struct EventViewDetailedAdmin_Previews: PreviewProvider {
    static var previews: some View {
        EventViewDetailedAdmin(event: Event(name: "Name", startDate: Date(), endDate: Date(), isCharity: false))
    }
}
