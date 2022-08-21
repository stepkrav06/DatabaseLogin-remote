//
//  AddTaskView.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 08.04.2022.
//

import SwiftUI

struct AddTaskView: View {
    var event: Event
    @EnvironmentObject var eventTasks: EventTasks
    @EnvironmentObject var viewModel: AppViewModel
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var importance: String = "1"
    @State private var tasksAddedAlertSuccess = false
    @State private var showUserList = false
    var body: some View {
        
        ZStack{
            VStack{
                
                
                Image(systemName: "square.and.pencil")
                    .font(.system(size: 100))
                    .padding()
                VStack {
                    TextField(
                        "Task name",
                        text: $name
                    )
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    
                    TextField(
                        "Description",
                        text: $description
                    )
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    
                    TextField(
                        "Importance",
                        text: $importance
                    )
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    Button(action: {showUserList.toggle()
                        
                    }){
                        Text("Select users to assign task")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(.teal)
                    .cornerRadius(8)
                    .sheet(isPresented: $showUserList){
                        AssignTaskToUserView()
                    }
                    
                }
                
                
                Button(action: {
                    guard !name.isEmpty, !description.isEmpty, !importance.isEmpty else{
                        return
                    }
                    let task = Task(name: name, importance: importance, description: description, ppl: eventTasks.users.count, people: eventTasks.usersId)
                    eventTasks.tasks.append(task)
                    DispatchQueue.main.async {
                        viewModel.addTasks(event: event, tasks: eventTasks.tasks)
                        for person in eventTasks.users{
                            viewModel.addTaskToPerson(newTask: task, person: person)
                        }
                    }
                    
                    
                    tasksAddedAlertSuccess = true
                    
                }){
                    Text("Add task")
                }
                .foregroundColor(.white)
                .padding()
                .background(.teal)
                .cornerRadius(8)
                .alert("Task added", isPresented: $tasksAddedAlertSuccess) {
                    Button("OK", role: .cancel) { }
                }
                
                Spacer()
                
                Spacer()
//                Button(action: {
//                    AddUser()
//
//                }){
//                    Text("Add user")
//                }
//                .foregroundColor(.white)
//                .padding()
//                .background(.orange)
//                .cornerRadius(8)
//                ForEach(userList.users) { user in
//                    Text(user.name)
//                }
            }
            .navigationTitle("Add tasks")
            
            
            
        }
        
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(event: Event(name: "Name", startDate: Date(), endDate: Date(), isCharity: false))
    }
}
