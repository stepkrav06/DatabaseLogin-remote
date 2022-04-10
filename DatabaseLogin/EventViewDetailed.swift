//
//  EventViewDetailed.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 08.04.2022.
//

import SwiftUI
import Firebase
struct EventViewDetailed: View {
    var event: Event
    @EnvironmentObject var tasks: EventTasks
    var body: some View {
        VStack{
            VStack{
            Text(event.name)
                .bold()
                .font(.title)
                .frame(alignment:.top)
                .padding()
            Text("Start date: \(event.startDate.formatted(date: .abbreviated, time: .omitted))")
                .padding()
            Text("End date: \(event.endDate.formatted(date: .abbreviated, time: .omitted))")
                
                .padding()
                if event.isCharity{
                    Text("Target sum: \(event.charitySum)")
                        
                        .padding()
                }
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(.primary)
            .padding()
            .background(.ultraThinMaterial)
            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .background(RoundedRectangle(cornerRadius: 30, style: .continuous).stroke(.black, lineWidth: 1).blur(radius: 4))
            
            .padding()
            List{
                
                Section {
                    ForEach(tasks.tasks) { task in
                        Text(task.content)
                            .badge(task.importance)
                    }
                  } header: {
                    Text("Tasks")
                  } footer: {
                    Text("\(tasks.tasks.count) tasks")
                  }
            }
        }
        .navigationTitle("Event details")
        .frame(maxWidth: .infinity)
        .onAppear{
            let ref = Database.database().reference(withPath: "tasks")
            ref.observe(.value) { snapshot in
                tasks.tasks = []
                // 3
                for child in snapshot.children {
                  // 4
                    if
                      let snapshot = child as? DataSnapshot,
                      let task = Task(snapshot: snapshot)
                     {
                        if event.tasks.contains(task.sid){
                            tasks.tasks.append(task)
                        }
                  }
                }
                } withCancel: { error in
                    print(error.localizedDescription)
                }
        }
    }
}

struct EventViewDetailed_Previews: PreviewProvider {
    static var previews: some View {
        EventViewDetailed(event: Event(name: "Name", startDate: Date(), endDate: Date(), isCharity: false))
    }
}
