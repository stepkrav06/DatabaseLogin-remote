//
//  AppViewModel.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 13.02.2023.
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
    @Published var gradesExported: Bool = false
    
    var isSignedIn: Bool  {
        return Auth.auth().currentUser != nil
    }
    func createUser(email: String, password: String, name: String, lastName: String, isAdmin: Bool, grade: String) {
        
        Auth.auth().createUser(withEmail: email, password: password) { res, error in
            if error != nil {
                self.createUserError = error!.localizedDescription
                
            } else {
                let user = User(uid: res!.user.uid, email: email, name: name, lastName: lastName, isAdmin: isAdmin, grade: grade)
                let ref = Database.database().reference(withPath: "users")
                let userRef = ref.child(res!.user.uid)
                userRef.setValue(user.toAnyObject())
                let gradeRef = Database.database().reference(withPath: "grades").child(res!.user.uid)
                let nulGrade = Grade(attendance: true, activity: "", comments: "")
                for event in self.eventList {
                    let eventGradeRef = gradeRef.child(event.sid)
                    eventGradeRef.setValue(nulGrade.toAnyObject())
                }
                
            }
            
        }
    }
    func logIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { user, error in

            guard user != nil, error == nil else {
                self.logInError = error!.localizedDescription
        
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
            
            Auth.auth().currentUser?.updatePassword(to: password) { error in
                if error != nil{
                    self.changePasswordError = error?.localizedDescription
                }
            }
        }
        
    }
    func addEvent(event: Event){
        let ref = Database.database().reference(withPath: "events")
        let eventRef = ref.child(event.sid)
        eventRef.setValue(event.toAnyObject())
        self.eventList.append(event)
        let gradeRef = Database.database().reference(withPath: "grades")
        let nulGrade = Grade(attendance: true, activity: "", comments: "")
        for user in userList{
            let gradeUserRef = gradeRef.child(user.uid).child(event.sid)
            gradeUserRef.setValue(nulGrade.toAnyObject())
        }
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
    func removeEvent(event: Event){
        var ref = Database.database().reference(withPath: "events").child(event.sid)
        ref.removeValue()
        
        for task in event.tasks{
            
            ref = Database.database().reference(withPath: "tasks").child(task)
            ref.removeValue()
            for user in self.userList{
                if user.tasks.contains(task){
                    let ind = user.tasks.firstIndex(of: task)
                    ref = Database.database().reference(withPath: "users").child(user.uid).child("tasks")
                    ref.observeSingleEvent(of: .value, with: { snapshot in
                        var userTasks: [String] = []
                        // 3
                        for child in snapshot.children {
                          // 4
                            if
                              let snapshot = child as? DataSnapshot
                             {
                                let taskId = snapshot.value as! String
                                userTasks.append(taskId)
                                
                                
                          }
                        }
                        if userTasks.count != 1 {
                            if let index = userTasks.firstIndex(of: task) {
                                userTasks.remove(at: index)
                            }
                            ref.setValue(userTasks as NSArray)
                        } else {
                            ref.child(String(ind!)).setValue("placeholder")
                        }
                    })
                    { (error) in
                       print(error.localizedDescription)
                   }
                    
                    
                }
            }
        }
        let gradeRef = Database.database().reference(withPath: "grades")
        for user in userList{
            let gradeRefUser = gradeRef.child(user.uid).child(event.sid)
                gradeRefUser.removeValue()
            
            
        }
        
        
    }
    func removeTask(task: Task){
        var ref = Database.database().reference(withPath: "tasks").child(task.sid)
        ref.removeValue()
        
        
            
        
        for event in self.eventList{
            if event.tasks.contains(task.sid){
                let ind = event.tasks.firstIndex(of: task.sid)
                ref = Database.database().reference(withPath: "events").child(event.sid).child("tasks")
                ref.observeSingleEvent(of: .value, with: { snapshot in
                    var tasks: [String] = []
                    // 3
                    for child in snapshot.children {
                      // 4
                        if
                          let snapshot = child as? DataSnapshot
                         {
                            let taskId = snapshot.value as! String
                            tasks.append(taskId)
                            
                            
                      }
                    }
                    if tasks.count != 1 {
                        if let index = tasks.firstIndex(of: task.sid) {
                          tasks.remove(at: index)
                        }
                        ref.setValue(tasks as NSArray)
                    } else {
                        ref.child(String(ind!)).setValue("placeholder")
                    }
                })
                { (error) in
                   print(error.localizedDescription)
               }
            }
        }
        
        
    }
    func removeTask2(task: Task){
        for user in self.userList{
            if user.tasks.contains(task.sid){
                let ind = user.tasks.firstIndex(of: task.sid)
                let ref = Database.database().reference(withPath: "users").child(user.uid).child("tasks")
                ref.observeSingleEvent(of: .value, with: { snapshot in
                    var userTasks: [String] = []
                    // 3
                    for child in snapshot.children {
                      // 4
                        if
                          let snapshot = child as? DataSnapshot
                         {
                            let taskId = snapshot.value as! String
                            userTasks.append(taskId)
                            
                            
                      }
                    }
                    let taskRef = ref.child(String(ind!))
                    if userTasks.count != 1 {
                        if let index = userTasks.firstIndex(of: task.sid) {
                            userTasks.remove(at: index)
                        }
                        ref.setValue(userTasks as NSArray)
                    } else {
                        taskRef.setValue("placeholder")
                    }
                })
                { (error) in
                   print(error.localizedDescription)
               }
                
               
            }
        }
    }
    func submitGrade(grade: Grade, user: User, event: Event){
        let ref = Database.database().reference(withPath: "grades").child(user.uid).child(event.sid)
        ref.setValue(grade.toAnyObject())
    }
    func deleteUser(user: User){
        Auth.auth().currentUser!.delete()
        let UserRef = Database.database().reference(withPath: "users").child(user.uid)
        UserRef.removeValue()
        let GradeRef = Database.database().reference(withPath: "grades").child(user.uid)
        GradeRef.removeValue()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
            self.logOut()
        }
        
    }
    func planMeeting(date: Date, comments: String, location: String, deviceToken : String){
        guard let url = URL(string: "https://fcm.googleapis.com/fcm/send") else {
            return
        }
        let json: [String: Any] = [
        
            "to": deviceToken,
            "notification": [
            
                "title": "A new meeting is planned",
                "body": "\(date.formatted()). " + comments,
                "sound": "default"
            ]
            
        ]
        
        let serverKey = "AAAAet8ZcFw:APA91bFLmcnhl1E_tTZE31ijMHStHUaoDitdRNs4fmBS_Pt4SjcdTx40vSTYqfZh5nvpDqk94AV4ssD-BcWlrYH4YmcCApuVxwrH9Cp5AGHIG-9B4iRVOby-l0KYUVPEN7q9y-ZrMXVG"
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=\(serverKey)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: request){ _, _, err in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            
        }
        .resume()
    }
}
