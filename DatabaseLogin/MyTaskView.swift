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
                
                Section {
                    ForEach(tasks) { task in
                        Text(task.content)
                            .badge(task.importance)
                    }
                  } header: {
                    Text("Tasks")
                  } footer: {
                    Text("\(tasks.count) tasks")
                  }
            }
        }
        .navigationTitle("My Tasks")
        .onAppear{
            var ref = Database.database().reference(withPath: "users")
            let userRef = ref.child(viewModel.currentLoggedUser!.uid)
            let tasksRef = userRef.child("tasks")
            tasksRef.observeSingleEvent(of: .value, with: { snapshot in
                var tasks: [String] = []
                // 3
                for child in snapshot.children {
                  // 4
                    if
                      let snapshot = child as? DataSnapshot
                     {
                        let taskId = snapshot.value as! String
                        if taskId != "placeholder"{
                            tasks.append(taskId)
                        }
                        
                  }
                }
                self.tasksId = tasks
                }) { (error) in
                    print(error.localizedDescription)
                }
            ref = Database.database().reference(withPath: "tasks")
            for taskId in tasksId{
                let taskRef = ref.child(taskId)
                taskRef.observeSingleEvent(of: .value, with: { snapshot in
                    var tasks: [Task] = []
                    // 3
                    
                      // 4
                        if
                          let task = Task(snapshot: snapshot)
                         {
                            tasks.append(task)
                            
                      }
                    
                    self.tasks = tasks
                    }) { (error) in
                        print(error.localizedDescription)
                    }
            }
        }
    }
}

struct MyTaskView_Previews: PreviewProvider {
    static var previews: some View {
        MyTaskView()
    }
}
