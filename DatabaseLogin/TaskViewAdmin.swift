//
//  TaskViewAdmin.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 10.08.2022.
//

import SwiftUI
import Firebase

struct TaskViewAdmin: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State var picked = true
    @Namespace var namespace
    @State var taskEventDict: [Event:[Task]] = [:]
    @State var taskIdEventDict: [Event:[String]] = [:]
    @State private var searchText = ""
    var body: some View {
        ZStack{
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .fill(.white)
                        .frame(maxHeight: 250, alignment: .top)
                    VStack{
                        HStack{
                            
                            Text("Upcoming")
                                .fontWeight(.thin)
                                .padding(.horizontal)
                                .foregroundColor(picked ? .teal : .black)
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.2, dampingFraction: 0.7)){
                                        picked = true
                                    }
                                }
                            
                            
                            Spacer()
                                .frame(maxWidth: 50)
                            
                            Text("Completed")
                                .fontWeight(.thin)
                                .padding(.horizontal)
                                .foregroundColor(!picked ? .teal : .black)
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.2, dampingFraction: 0.7)){
                                        picked = false
                                    }
                                }
                            
                        }
                        HStack{
                            RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .fill(.teal)
                                .frame(maxWidth: 40, maxHeight: 5)
                                .offset(x: picked ? -80 : 80)
                        }
                        
                    }.frame(maxHeight: 250, alignment: .bottom)
                }
                
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(Array(taskEventDict.keys).sorted(by: { $0.endDate < $1.endDate }), id: \.self) { event in
                            
                            
                            if event.endDate > Date.now && picked{
                                Text(event.name + " (\(event.endDate.formatted(date: .abbreviated, time: .omitted)))")
                                    .font(.title)
                                    .fontWeight(.light)
                                    .padding()
                                
                                if taskEventDict[event]!.isEmpty{
                                    Text("No tasks assigned")
                                        .font(.body)
                                        .fontWeight(.thin)
                                        .padding(.horizontal, 20)
                                }
                                
                                Group {
                                    ForEach(taskEventDict[event]!){ task in
                                     
                                        TaskViewCard(taskName: task.name, taskDescription: task.description, importance: task.importance, numPeople: task.pplAssigned)
                                    }
                                }
                            }
                            else if event.endDate < Date.now && !picked{
                                Text(event.name + " (\(event.endDate.formatted(date: .abbreviated, time: .omitted)))")
                                    .font(.title)
                                    .fontWeight(.light)
                                    .padding()
                                
                                if taskEventDict[event]!.isEmpty{
                                    Text("No tasks assigned")
                                        .font(.body)
                                        .fontWeight(.thin)
                                        .padding(.horizontal, 20)
                                }
                                
                                Group {
                                    ForEach(taskEventDict[event]!){ task in
                                      
                                        TaskViewCard(taskName: task.name, taskDescription: task.description, importance: task.importance, numPeople: task.pplAssigned)
                                    }
                                }
                            }
                            
                            
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment:.top)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment:.top)
            
            
        }
        .searchable(text: $searchText, prompt: "Search")
        .navigationTitle("Tasks")
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.secondary)
        
        .onAppear{
            for event in viewModel.eventList{
                taskEventDict[event] = []
                taskIdEventDict[event] = []
            }
            var ref = Database.database().reference(withPath: "events")
            for event in viewModel.eventList{
                ref = Database.database().reference(withPath: "events")
                
                
                let eventRef = ref.child(event.sid)
                let tasksRef = eventRef.child("tasks")
                tasksRef.observe(.value) { snapshot in
                    
                    // 3
                    for child in snapshot.children {
                        // 4
                        if
                            let snapshot = child as? DataSnapshot
                        {
                            let taskId = snapshot.value as! String
                            print(taskId)
                            if taskId != "placeholder"{
                                self.taskIdEventDict[event]!.append(taskId)
                            }
                            
                            
                        }
                    }
                    
                    ref = Database.database().reference(withPath: "tasks")
                    
                    for taskId in taskIdEventDict[event]!{
                        let taskRef = ref.child(taskId)
                        
                        taskRef.observe(.value) { snapshot in
                            
                            // 3
                            
                            // 4
                            if
                                let task = Task(snapshot: snapshot)
                            {
                                self.taskEventDict[event]!.append(task)
                                
                            }
                            
                            
                        } withCancel: { error in
                            print(error.localizedDescription)
                        }
                    }
                } withCancel: { error in
                    print(error.localizedDescription)
                }
                
                
                
            }
        }
    }
}

struct TaskViewAdmin_Previews: PreviewProvider {
    static var previews: some View {
        TaskViewAdmin()
    }
}
