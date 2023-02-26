//
//  AppViewModel.swift
//
//  Used for all the variables and methods that are used throughout the program (mostly related to working with the database)
//
//

import SwiftUI
import Firebase
class AppViewModel: ObservableObject {
    // instance variables (can be accessed from all the views)
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
    
    /*
     A function for creating a new user
     arguments:
        -email: The email (login) for the new account
        -password: The password for the new account
        -name: The name of the new student added
        -lastName: The last name of the new student added
        -isAdmin: Whether the new user will have access to admin functions
        -grade: The grade the new student is in
     return:
        -void
     result:
        -new account created in the authentication system, user information written to the database
     */
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
    
    /*
     A function for logging in
     arguments:
        -email: The login for the account
        -password: The password for the account
     return:
        -void
     result:
        -logged into the account with the specified login information
     */
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
    
    /*
     A function for logging out
     return:
        -void
     result:
        -logged out of the current account
     */
    func logOut(){
        try? Auth.auth().signOut()
        
        self.signedIn = false
        self.currentLoggedUser = nil
    }
    
    /*
     A function for changing the password
     arguments:
        -password: The new password
        -confirmPassword: The new password again for confirmation
     return:
        -void
     result:
        -password for the currently logged in account changed
     */
    func changePassword(password: String, confirmPassword: String){
        if password == confirmPassword {
            
            Auth.auth().currentUser?.updatePassword(to: password) { error in
                if error != nil{
                    self.changePasswordError = error?.localizedDescription
                }
            }
        }
        
    }
    
    /*
     A function for adding an event
     arguments:
        -event: An Event object with the information about the new event
     return:
        -void
     result:
        -information about the new event written to the database
     */
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
    
    /*
     A function for adding multiple tasks
     arguments:
        -event: The Event object to which the tasks are added
        -tasks: The list of Task objects to add
     return:
        -void
     result:
        -the information about the new Tasks written to the database
     */
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
    
    /*
     A function for assigning a task to a person
     arguments:
        -newTask: The Task object with the information about the new task to add
        -person: The User object with the information about the person to which the new task is assigned
     return:
        -void
     result:
        -the information about the new task is written to the database
     */
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
    
    /*
     A function for removing an event
     arguments:
        -event: The Event object with the information about the event to remove
     return:
        -void
     result:
        -the information about the event reomved from the database
     */
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
    
    /*
     A function for removing a task (to be used together with the removeTask2() method)
     arguments:
        -task: The Task object with the information about the task to remove
     return:
        -void
     result:
        -the information about the task removed from the database
     */
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
    
    /*
     A function for removing a task (to be used together with the removeTask() method)
     arguments:
        -task: The Task object with the information about the task to remove
     return:
        -void
     result:
        -the information about the task removed from the database
     */
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
    
    /*
     A function for submitting a grade for a person
     arguments:
        -grade: The Grade object with the information about the grade to submit
        -user: The User object with the information about the user to which the grade is given
        -event: The Event object with the information about the event for which the grade is given
     return:
        -void
     result:
        -the information about the grade written to the database
     */
    func submitGrade(grade: Grade, user: User, event: Event){
        let ref = Database.database().reference(withPath: "grades").child(user.uid).child(event.sid)
        ref.setValue(grade.toAnyObject())
    }
    
    /*
     A function for removing a user
     arguments:
        -user: The User object with the information about the user to remove
     return:
        -void
     result:
        -the information about the user removed from the database, the user account removed from the authentication system
     */
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
    
    /*
     A function for planning a meeting (and sending a push notification)
     arguments:
        -date: The date for the new meeting
        -comments: Comments about the meeting
        -location: Where the meeting will be comducted (room number)
        -deviceToken: The token (specific to each device) used to identify a device in the APN service
     return:
        -void
     result:
        -the information about the new meeting is written to the database, a push notification is sent
     */
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
