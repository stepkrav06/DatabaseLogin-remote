//
//  ExportGradesView.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 15.08.2022.
//

import SwiftUI
import Firebase
import Foundation

struct ExportGradesView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State var pickedEvents: [Event:Bool] = [:]
    @State var pickedUsers: [User:Bool] = [:]
    var body: some View {
        
            
                ScrollView {
                    VStack{
                        VStack{
                    Text("Events")
                        .font(.title)
                        .fontWeight(.thin)
                    ForEach(viewModel.eventList){event in
                        ZStack{
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .fill(pickedEvents[event] ?? false ? .green : .clear)
                                .frame(height: 50)
                                .padding(8)
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .stroke(pickedEvents[event] ?? false ? .clear : .textColor1)
                                .frame(height: 50)
                                .padding(8)
                            HStack{
                                Text(event.name)
                                    .foregroundColor(pickedEvents[event] ?? false ? .textColor2 : .textColor1)
                                if pickedEvents[event] ?? false{
                                    Image(systemName: "checkmark")
                                        .foregroundColor(pickedEvents[event] ?? false ? .textColor2 : .textColor1)
                                }
                            }
                        }
                        .onTapGesture {
                            if pickedEvents[event]!{
                                pickedEvents[event] = false
                            } else {
                                pickedEvents[event] = true
                            }
                        }
                    }
                }
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding()
                Spacer()
                
                    VStack{
                        Text("People")
                            .font(.title)
                            .fontWeight(.thin)
                        ForEach(viewModel.userList){user in
                            ZStack{
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .fill(pickedUsers[user] ?? false ? .green : .clear)
                                    .frame(height: 50)
                                    .padding(8)
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .stroke(pickedUsers[user] ?? false ? .clear : .textColor1)
                                    .frame(height: 50)
                                    .padding(8)
                                HStack{
                                    Text(user.name + " " + user.lastName)
                                        .foregroundColor(pickedUsers[user] ?? false ? .textColor2 : .textColor1)
                                    if pickedUsers[user] ?? false{
                                        Image(systemName: "checkmark")
                                            .foregroundColor(pickedUsers[user] ?? false ? .textColor2 : .textColor1)
                                    }
                                }
                            }
                            .onTapGesture {
                                if pickedUsers[user]!{
                                    pickedUsers[user] = false
                                } else {
                                    pickedUsers[user] = true
                                }
                            }
                        }
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding()
                    }
                }
        
            
        
        .navigationTitle("Export grades")
        .toolbar {
           
                Button(action: {
//                    let events = pickedEvents.filter { $1 == true }.map { $0.0 }
//                    let users = pickedUsers.filter { $1 == true }.map { $0.0 }
//                    let grades = getGradesForUsersAndEvents(userList: users, eventList: events)
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                        let url = createSummaryByUser(userList: users, eventList: events, grades: grades)
//                        actionSheet(url: url)
//                    }
                    
                    
                }){
                    NavigationLink(destination: ShareLoading(users: pickedUsers, events: pickedEvents)){
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(Color.textColor1)
                    }
                    
                    
                }
                
                
            
            
        }
        .onAppear{
            for event in viewModel.eventList{
                self.pickedEvents[event] = false
            }
            for user in viewModel.userList{
                self.pickedUsers[user] = false
            }
            
            
    }
    }
    func actionSheet(url: String) {
            guard let urlShare = URL(string: url) else { return }
            let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
            UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
        }
    func createSummaryByUser(userList: [User], eventList: [Event], grades: [String:[String:Grade]]) -> String{
        var fileContent = ""
        fileContent.append("The report for the student council activity\n\n")
        var personNum = 1
        for person in userList{
            fileContent.append("\(personNum). \(person.name) \(person.lastName):\n")
            for event in eventList{
                fileContent.append("\t\(event.name) (\(event.startDate.formatted(.dateTime .day(.defaultDigits).month(.defaultDigits).year(.defaultDigits).locale(Locale(identifier: "ru")))) - \(event.endDate.formatted(.dateTime .day(.defaultDigits).month(.defaultDigits).year(.defaultDigits).locale(Locale(identifier: "ru"))))):\n")
                if !(grades[person.uid]?[event.sid]!.attendance)! {
                    fileContent.append("\t\tThe student has not participated in this event")
                    break
                }
                fileContent.append("\t\tParticipation in the event: \(grades[person.uid]?[event.sid]?.activity ?? "0")\n")
                fileContent.append("\t\tComments: \(grades[person.uid]?[event.sid]?.comments ?? "")\n")
            }
            personNum+=1
        }
        let file = "Report \(Date()).txt"
        let contents = "bububu"
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = dir.appendingPathComponent(file)
        print(fileURL)

        do {
            try contents.write(to: fileURL, atomically: false, encoding: .utf8)
        }
        catch {
            print("Error: \(error)")
        }
        return fileURL.absoluteString
        
    }
    func getGradesForUsersAndEvents(userList: [User], eventList: [Event]) -> [String:[String:Grade]]{
        var grades: [String:[String:Grade]] = [:]
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
        return grades
    }
}

struct ExportGradesView_Previews: PreviewProvider {
    static var previews: some View {
        ExportGradesView()
    }
}
