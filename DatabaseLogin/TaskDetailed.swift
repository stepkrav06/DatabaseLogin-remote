//
//  TaskDetailed.swift
//
//  The view with the detailed infrmation about a task
//
//

import SwiftUI
import Firebase

struct TaskDetailed: View {
    @EnvironmentObject var viewModel: AppViewModel
    var task: Task
    @State var users: [String] = []
    @Environment(\.dismiss) var dismiss
    @State private var taskRemoveAlert = false
    
    let importanceText = ["not very important", "important", "very important"]
    var body: some View {
        ScrollView{
        VStack(spacing: 5){
            Group{
            Text("Task")
                .fontWeight(.thin)
                .italic()
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.top)
                .padding(.horizontal)
            RoundedRectangle(cornerRadius: 50, style: .continuous)
                .frame(height: 1)
                .padding(.vertical, 4)
                .padding(.horizontal)
            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .frame(height: 50)
                    .foregroundColor(Color.lightGray)
                    .padding(.vertical, 4)
                    .padding(.horizontal)
                Text(task.name)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding()
                .padding(.horizontal)
                .foregroundColor(.black)
            }
            }
            Group{
            Text("Description")
                .fontWeight(.thin)
                .italic()
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.top)
                .padding(.horizontal)
            RoundedRectangle(cornerRadius: 50, style: .continuous)
                .frame(height: 1)
                .padding(.vertical, 4)
                .padding(.horizontal)
            ZStack {
                
                Text(task.description)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(32)
                .foregroundColor(.black)
                
                .background(RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .frame(minHeight: 50)
                    .foregroundColor(Color.lightGray)
                    .padding())
            }
            }
            Group{
            Text("Importance")
                .fontWeight(.thin)
                .italic()
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.top)
                .padding(.horizontal)
            RoundedRectangle(cornerRadius: 50, style: .continuous)
                .frame(height: 1)
                .padding(.vertical, 4)
                .padding(.horizontal)
            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .frame(height: 50)
                    .foregroundColor(Color.lightGray)
                    .padding(.vertical, 4)
                    .padding(.horizontal)
                Text(task.importance + " (\(importanceText[Int(task.importance)!-1]))")
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding()
                .padding(.horizontal)
                .foregroundColor(.black)
            }
            }
            Group{
            Text("People")
                .fontWeight(.thin)
                .italic()
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.top)
                .padding(.horizontal)
            RoundedRectangle(cornerRadius: 50, style: .continuous)
                .frame(height: 1)
                .padding(.vertical, 4)
                .padding(.horizontal)
                
                ForEach(users.indices, id: \.self) {
                                 Text(self.users[$0])
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding()
                        .padding(.horizontal)
                    
                            }
                
            }
            if viewModel.currentLoggedUser!.isAdmin{
                // shown only for admin users
                Button(action: {taskRemoveAlert.toggle()}){
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(.red)
                            .frame(height:50)
                            .padding()
                        Text("Remove task")
                            .foregroundColor(.white)
                    }
                        
                    
                    
                }
                .alert("You want to delete the task?", isPresented: $taskRemoveAlert) {
                    Button("Cancel", role: .cancel) { }
                    Button("Yes", role: .destructive) {
                        viewModel.removeTask(task: task)
                        viewModel.removeTask2(task: task)
                        dismiss()
                        
                    }
                }
            }
            Spacer()
        }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("Task")
        .onAppear{
            // list of users the task is assigned to is loaded
            let ref = Database.database().reference(withPath: "users")
            for user in task.people{
                
                
                let userRef = ref.child(user)
                
                userRef.observe(.value) { snapshot in
                    

                        
                            let user = User(snapshot: snapshot)
                            let userName = user!.name + " " + user!.lastName
                            users.append(userName)
                            
                            
                        
                    
                
                
                
                
            }
            withCancel: { error in
                print(error.localizedDescription)
            }
        }
        }
    }
}

struct TaskDetailed_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailed(task: Task(name: "name", importance: "1", description: "description description description description description description description description description description description description description description", ppl: 1, people: ["11"]))
    }
}
