//
//  ContentView.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 29.03.2022.
//

import SwiftUI
import Firebase

class AppViewModel: ObservableObject {
    
    @Published var createUserError: String?
    @Published var logInError: String?
    @Published var changePasswordError: String?
    @Published var signedIn: Bool = false
    @Published var currentLoggedUser: User? = nil
    @Published var isWriting: Bool = false
    @Published var userList: [User] = []
    @Published var eventList: [Event] = []
    
    var isSignedIn: Bool  {
        return Auth.auth().currentUser != nil
    }
    func createUser(email: String, password: String, name: String, lastName: String, isAdmin: Bool) {
        
        Auth.auth().createUser(withEmail: email, password: password) { res, error in
            if error != nil {
                self.createUserError = error?.localizedDescription ?? ""
                print(self.createUserError!)
            } else {
                let user = User(uid: res!.user.uid, email: email, name: name, lastName: lastName, isAdmin: isAdmin)
                let ref = Database.database().reference(withPath: "users")
                let userRef = ref.child(res!.user.uid)
                userRef.setValue(user.toAnyObject())
            }
            
        }
    }
    func logIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { user, error in

            guard user != nil, error == nil else {
                self.logInError = error!.localizedDescription
                print(self.logInError!)
                return
            }
            DispatchQueue.main.async {
                //Success
                self.signedIn = true
            }
        }
    }
    func logOut(){
        try? Auth.auth().signOut()
        
        self.signedIn = false
        self.currentLoggedUser = nil
    }
    func changePassword(password: String, confirmPassword: String){
        if password == confirmPassword {
            print("bebe")
            Auth.auth().currentUser?.updatePassword(to: password) { error in
                if error != nil{
                    self.changePasswordError = error?.localizedDescription
                }
            }
        }
        print("no bebe")
    }
    func addEvent(event: Event){
        let ref = Database.database().reference(withPath: "events")
        let eventRef = ref.child(event.sid)
        eventRef.setValue(event.toAnyObject())
    }
    func changeEvent(event: Event, name: String, startDate: Date, endDate: Date, isCharity: Bool, charitySum: String){
        let ref = Database.database().reference(withPath: "events")
        let eventRef = ref.child(event.sid)
        let newEvent = Event(name: name, startDate: startDate, endDate: endDate, isCharity: isCharity, charitySum: charitySum, tasks: event.tasks)
        eventRef.setValue(newEvent.toAnyObject())
    }
    func addTasks(event: Event, tasks: [Task]){
        let ref = Database.database().reference(withPath: "events")
        let eventRef = ref.child(event.sid)
        let eventTasksRef = eventRef.child("tasks")
        var taskList: [String] = []
        for task in tasks{
            taskList.append(task.sid)
        }
        eventTasksRef.setValue(taskList as NSArray)
        let refTasks = Database.database().reference(withPath: "tasks")
        for task in tasks{
            let refTask = refTasks.child(task.sid)
            refTask.setValue(task.toAnyObject())
        }
    }
    func addTaskToPerson(newTask: Task, person: User){
        let ref = Database.database().reference(withPath: "users")
        let userRef = ref.child(person.uid)
        let userTasksRef = userRef.child("tasks")
//        userTasksRef.getData(completion:  { error, snapshot in
//            guard error == nil else {
//              print(error!.localizedDescription)
//              return;
//            }
//
//            var tasks: [String] = []
//            // 3
//            for child in snapshot.children {
//              // 4
//                if
//                  let snapshot = child as? DataSnapshot
//                 {
//                    let taskId = snapshot.value as! String
//                    if taskId != "placeholder"{
//                        tasks.append(taskId)
//                    }
//
//              }
//            }
//            tasks.append(newTask.sid)
//            userTasksRef.setValue(tasks as NSArray)
//          })
        userTasksRef.observeSingleEvent(of: .value, with: { snapshot in
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
            tasks.append(newTask.sid)
            userTasksRef.setValue(tasks as NSArray)
            }) { (error) in
                print(error.localizedDescription)
            }
        
        
    }
}


struct ContentView: View {
    @EnvironmentObject var viewModel: AppViewModel
//    @EnvironmentObject var userList: Users
    
    var body: some View {
        NavigationView{
            if viewModel.signedIn {
                if viewModel.currentLoggedUser != nil && viewModel.userList != [] {
                    if viewModel.currentLoggedUser?.isAdmin == true{
                        TabViewAdmin()
                    }
                    else{
                        TabViewNonAdmin()
                    }
                    
                }
                else{
                    LoadingView()
                        .onAppear{
                            var ref = Database.database().reference(withPath: "users")
                            let user = Auth.auth().currentUser
                            print(user?.email)
                            let userPath = ref.child(user!.uid)
                            userPath.observe(.value) { snapshot in
                                    let curuser = User(snapshot: snapshot)
                                    viewModel.currentLoggedUser = curuser
                                    print(viewModel.currentLoggedUser?.isAdmin)
                                } withCancel: { error in
                                    print(error.localizedDescription)
                                }
                            let completed = ref.observe(.value) { snapshot in
                              // 2
                              var users: [User] = []
                              // 3
                              for child in snapshot.children {
                                // 4
                                  if
                                    let snapshot = child as? DataSnapshot,
                                  let user = User(snapshot: snapshot) {
                                    users.append(user)
                                }
                              }
                                viewModel.userList = users
                                
                                for user in users {
                                    print(user.name)
                                    print(user.tasks)
                                }
                                viewModel.isWriting = false
                            }
                                
                            ref = Database.database().reference(withPath: "events")
                            let completed2 = ref.observe(.value) { snapshot in
                              // 2
                              var events: [Event] = []
                              // 3
                              for child in snapshot.children {
                                // 4
                                  if
                                    let snapshot = child as? DataSnapshot,
                                  let event = Event(snapshot: snapshot) {
                                    events.append(event)
                                }
                              }
                                viewModel.eventList = events
                                
                            }
                            
                        
                }
                
                }
                
            } else {
                LoginPage()
            }
            
        }
        .onAppear{
            viewModel.signedIn = viewModel.isSignedIn
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
