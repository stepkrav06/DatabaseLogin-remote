//
//  TaskViewAdmin.swift
//
//  The tasks page
//
//

import SwiftUI
import Firebase

struct TaskView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State var picked = true
    @State var taskEventDict: [Event:[Task]] = [:]
    @State var taskIdEventDict: [Event:[String]] = [:]
    @State private var searchText = ""
    var body: some View {
        ZStack{
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .fill(Color.textColor2)
                        .frame(maxHeight: 250, alignment: .top)
                    VStack{
                        HStack{
                            
                            Text("Upcoming")
                                .fontWeight(.thin)
                                .padding(.horizontal)
                                .foregroundColor(picked ? .teal : .primary)
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
                                .foregroundColor(!picked ? .teal : .primary)
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
                                // upcoming tasks
                                Text(event.name + " (\(event.endDate.formatted(date: .abbreviated, time: .omitted)))")
                                    .font(.title)
                                    .fontWeight(.light)
                                    .padding()
                                    .foregroundColor(.black)
                                
                                if taskEventDict[event]!.isEmpty{
                                    Text("No tasks assigned")
                                        .font(.body)
                                        .fontWeight(.thin)
                                        .padding(.horizontal, 20)
                                        .foregroundColor(.black)
                                }
                                
                                Group {
                                    ForEach(searchResults(event: event).sorted(by: { $0.name < $1.name })){ task in
                                        // searched tasks (all tasks if search is empty)
                                        NavigationLink(destination: TaskDetailed(task: task)){
                                        TaskViewCard(taskName: task.name, taskId: task.sid, taskDescription: task.description, importance: task.importance, numPeople: task.pplAssigned)
                                        }
                                    }
                                }
                            }
                            else if event.endDate < Date.now && !picked{
                                // completed tasks
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
                                    ForEach(searchResults(event: event).sorted(by: { $0.name < $1.name })){ task in
                                        // searched tasks (all tasks if search is empty)
                                        NavigationLink(destination: TaskDetailed(task: task)){
                                        TaskViewCard(taskName: task.name, taskId: task.sid, taskDescription: task.description, importance: task.importance, numPeople: task.pplAssigned)
                                        }
                                    }
                                }
                            }
                            
                            
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment:.top)
                Spacer()
                    .frame(height: 130)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment:.top)
            
            
        }
        .searchable(text: $searchText, prompt: "Search")
        .navigationTitle("Tasks")
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.bg1)
        
        .onAppear{
            // task information loaded
            for event in viewModel.eventList{
                taskEventDict[event] = []
                taskIdEventDict[event] = []
            }
            var ref = Database.database().reference(withPath: "events")
            for event in viewModel.eventList{
                ref = Database.database().reference(withPath: "events")
                
                
                let eventRef = ref.child(event.sid)
                let tasksRef = eventRef.child("tasks")
                tasksRef.observeSingleEvent(of :.value) { snapshot in
                    
                    // 3
                    for child in snapshot.children {
                        // 4
                        if
                            let snapshot = child as? DataSnapshot
                        {
                            let taskId = snapshot.value as! String
                     
                            if taskId != "placeholder"{
                                self.taskIdEventDict[event]!.append(taskId)
                            }
                            
                            
                        }
                    }
                    
                    ref = Database.database().reference(withPath: "tasks")
                    
                    for taskId in taskIdEventDict[event]!{
                        let taskRef = ref.child(taskId)
                        
                        taskRef.observeSingleEvent(of: .value) { snapshot in
                            
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
    /*
      A function for serching the task list
      arguments:
         -event: The Event object for which the tasks are assigned
      return:
         -[Task]: array of Task objects that fit the search criteria
      result:
         -only the Task objects that fit the search criteria are returned
      */
    func searchResults(event: Event) -> [Task] {
            if searchText.isEmpty {
                return taskEventDict[event]!
            } else {
                return taskEventDict[event]!.filter { $0.name.contains(searchText) || $0.description.contains(searchText)}
            }
        }
}

struct TaskViewAdmin_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
    }
}
