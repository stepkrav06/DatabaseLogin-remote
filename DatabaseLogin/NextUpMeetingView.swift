//
//  NextUpMeetingView.swift
//
//  Card with the information about the next planned meeting
//
//

import SwiftUI
import Firebase

struct NextUpMeetingView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State var meeting: Meeting = Meeting(date: Date(), location: "", comments: "")
    @State var meetingPlanned = false
    var body: some View {
        ZStack{
        if meetingPlanned{
            // shown if a meeting is planned
            VStack(alignment: .leading, spacing: 5){
            
            Text("Next meeting planned")
                .font(.title)
                .bold()
                
            Text("Meeting time: \(meeting.date.formatted(.dateTime .day(.defaultDigits).month(.defaultDigits).year(.defaultDigits).hour(.defaultDigits(amPM: .omitted)).minute(.defaultDigits).locale(Locale(identifier: "ru"))))")
                .fontWeight(.light)
            Text("Location: \(meeting.location)")
                    .fontWeight(.light)
                
            Text("Comments: \(meeting.comments)")
                    
        }
            .frame(maxWidth: .infinity, minHeight: 150, maxHeight: 250, alignment: .topLeading)
        .foregroundColor(.primary)
        .padding(32)
        .background(.ultraThinMaterial)
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .background(RoundedRectangle(cornerRadius: 30, style: .continuous).stroke(.primary, lineWidth: 1).blur(radius: 4))
        .padding()
            } else {
                // shown if no meeting is planned
                VStack(spacing: 5){
                Text("No meetings planned")
                    .padding()
                if viewModel.currentLoggedUser!.isAdmin{
                NavigationLink(destination: PlanNewMeetingView()){
                    Image(systemName: "plus")
                        .font(.largeTitle)
                        .foregroundColor(.textColor1)
                }
                }
                }
                .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200)
                .foregroundColor(.primary)
                .padding()
                .background(.ultraThinMaterial)
                .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .background(RoundedRectangle(cornerRadius: 30, style: .continuous).stroke(.primary, lineWidth: 1).blur(radius: 4))
                .padding()
            }
                
            
        
        
        }
        .onAppear{
            // loading the next meeting information
            let ref = Database.database().reference(withPath: "nextMeeting")
            ref.observeSingleEvent(of: .value, with: { snapshot in
                
                meeting = Meeting(snapshot: snapshot) ?? Meeting(date: Date(), location: "", comments: "")
                if meeting.location == ""{
                    meetingPlanned = false
                } else {
                    if meeting.date < Date(){
                        
                        meetingPlanned = false
                        ref.removeValue()
                    } else {
                        meetingPlanned = true
                    }
                    
                }
                
            })
            { (error) in
                print(error.localizedDescription)
            }
        }
    }
}

struct NextUpMeetingView_Previews: PreviewProvider {
    static var previews: some View {
        NextUpMeetingView()
    }
}
