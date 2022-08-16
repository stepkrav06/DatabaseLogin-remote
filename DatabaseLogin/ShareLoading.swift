//
//  ShareLoding.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 16.08.2022.
//

import SwiftUI
import Firebase

struct ShareLoading: View {
    var users: [User:Bool]
    var events: [Event:Bool]
    @State var grades: [String:[String:Grade]] = [:]
    @State var loaded = false
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AppViewModel
    @State private var shareAlert = false
    var body: some View {
        VStack{
            LoadingView()
//            Button(action:{shareAlert.toggle()}){
//                ZStack{
//                    RoundedRectangle(cornerRadius: 20, style: .continuous)
//                        .fill(.red)
//                        .frame(height:50)
//                        .padding()
//                    Text("Share")
//                        .foregroundColor(.white)
//                }
//            }
//            .alert("You want to delete the task?", isPresented: $shareAlert) {
//                Button("Cancel", role: .cancel) { }
//                Button("Yes", role: .destructive) {
//                    viewModel.removeTask(task: task)
//                    viewModel.removeTask2(task: task)
//                    dismiss()
//                    
//                }
//            }
        }
                .onAppear{
                    if !viewModel.gradesExported{
                    let eventList = events.filter { $1 == true }.map { $0.0 }
                    let userList = users.filter { $1 == true }.map { $0.0 }
                    let ref = Database.database().reference(withPath: "grades")
                    for user in userList{
                        grades[user.uid] = [:]
                    }
                    
                    for user in userList{
                        
                        let userRef = ref.child(user.uid)
                        var eventGrades: [String:Grade] = [:]
                        for event in eventList{
                            let eventRef = userRef.child(event.sid)
                            
                            eventRef.observeSingleEvent(of: .value, with: { snapshot in
                                    
                                let grade = Grade(snapshot: snapshot)
                                eventGrades[event.sid] = grade
                                grades[user.uid]![event.sid] = grade

                                print(grades[user.uid])
                                }) { (error) in
                                    print(error.localizedDescription)
                                }
                        }
                        
                        
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        let url = createSummaryByUser(userList: userList, eventList: eventList, grades: grades)
                        actionSheet(url: url)
                        dismiss()
                        viewModel.gradesExported = true
                    }
                    }
                    
            }
        
    }
    func createSummaryByUser(userList: [User], eventList: [Event], grades: [String:[String:Grade]]) -> String{
        var fileContent = ""
        fileContent.append("The report for the student council activity\n\n")
        var personNum = 1
        
        for person in userList{
            fileContent.append("\(personNum). \(person.name) \(person.lastName):\n")
            for event in eventList{
                fileContent.append("\t\(event.name) (\(event.startDate.formatted(.dateTime .day(.defaultDigits).month(.defaultDigits).year(.defaultDigits).locale(Locale(identifier: "ru")))) - \(event.endDate.formatted(.dateTime .day(.defaultDigits).month(.defaultDigits).year(.defaultDigits).locale(Locale(identifier: "ru"))))):\n")
                if !(grades[person.uid]![event.sid]!.attendance) {
                    fileContent.append("\t\tThe student has not participated in this event\n")
                    break
                }
                fileContent.append("\t\tParticipation in the event: \(grades[person.uid]![event.sid]!.activity )\n")
                fileContent.append("\t\tComments: \(grades[person.uid]![event.sid]!.comments )\n")
            }
            personNum+=1
        }
        
        let file = "Report \(Date().formatted(.dateTime .day(.defaultDigits).month(.defaultDigits).year(.defaultDigits).locale(Locale(identifier: "ru")))).txt"
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = dir.appendingPathComponent(file)
        print(fileURL)

        do {
            try fileContent.write(to: fileURL, atomically: false, encoding: .utf8)
        }
        catch {
            print("Error: \(error)")
        }
        return fileURL.absoluteString
        
    }
    func actionSheet(url: String) {
            guard let urlShare = URL(string: url) else { return }
            let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
            UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
        }
}

struct ShareLoding_Previews: PreviewProvider {
    static var previews: some View {
        ShareLoading(users: [:], events: [:])
    }
}
