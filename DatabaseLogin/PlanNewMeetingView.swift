//
//  PlanNewMeetingView.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 20.08.2022.
//

import SwiftUI
import Firebase

struct PlanNewMeetingView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AppViewModel
    @State private var dateTime = Date()
    @State private var comments = ""
    @State private var location = ""
    var body: some View {
        List{
            Section {
                DatePicker("Date and time", selection: $dateTime, displayedComponents: [.date, .hourAndMinute])
            } header: {
                Text("Date")
            }
            Section {
                TextField("", text: $comments)
            } header: {
                Text("Comments")
            }
            Section {
                TextField("", text: $location)
            } header: {
                Text("Location")
            }
            Section{
                Button(action:{
                    let ref = Database.database().reference(withPath: "deviceTokens")
                    ref.observeSingleEvent(of :.value) { snapshot in
                        
                        
                        
                        let tokens = snapshot.value as? [String] ?? []
                        print(tokens)
                        for token in tokens{
                            
                            viewModel.planMeeting(date: dateTime, comments: comments, location: location, deviceToken: token)
                        }
                        
                        
                        
                        
                    } withCancel: { error in
                        print(error.localizedDescription)
                    }
                    let meeting = Meeting(date: dateTime, location: location, comments: comments)
                    let meetingRef = Database.database().reference(withPath: "nextMeeting")
                    meetingRef.setValue(meeting.toAnyObject())
                    dismiss()
                }){
                    Text("Send notification")
                        .foregroundColor(.textColor1)
                        
                }
            }
            
            
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Plan Meeting")
        
    }
}

struct PlanNewMeetingView_Previews: PreviewProvider {
    static var previews: some View {
        PlanNewMeetingView()
    }
}
