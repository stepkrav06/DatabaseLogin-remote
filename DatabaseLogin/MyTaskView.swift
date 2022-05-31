//
//  MyTaskView.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 10.04.2022.
//

import SwiftUI
import Firebase

struct MyTaskView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State var tasksId: [String] = []
    @State var tasks: [Task] = []
    var body: some View {
        VStack{
            Text("You have \(tasks.count) tasks assigned")
            List{
                
                Section(header: Text("Tasks"), footer: Text("\(tasks.count) tasks")) {
                    ForEach(tasks) { task in
                        Text(task.content)
                            .badge(task.importance)
                    }
                  }
            }
            .listStyle(.insetGrouped)
            
        }
        .navigationTitle("My Tasks")
        .onAppear{
            var ref = Database.database().reference(withPath: "users")
            let userRef = ref.child(viewModel.currentLoggedUser!.uid)
            let tasksRef = userRef.child("tasks")
            tasksRef.observe(.value) { snapshot in
                
                // 3
                for child in snapshot.children {
                  // 4
                    if
                      let snapshot = child as? DataSnapshot
                     {
                        let taskId = snapshot.value as! String
                        if taskId != "placeholder"{
                            self.tasksId.append(taskId)
                        }
                        
                        
                  }
                }
                ref = Database.database().reference(withPath: "tasks")
                
                for taskId in tasksId{
                    let taskRef = ref.child(taskId)
                    
                    taskRef.observe(.value) { snapshot in
                        
                        // 3
                        
                          // 4
                            if
                              let task = Task(snapshot: snapshot)
                             {
                                self.tasks.append(task)
                                
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

struct MyTaskView_Previews: PreviewProvider {
    static var previews: some View {
        MyTaskView()
    }
}
