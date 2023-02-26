//
//  EventViewDetailedAdmin.swift
//  
//  The view with detailed event informaiton for admin users
//
//

import SwiftUI
import Firebase

struct EventViewDetailedAdmin: View {
    @EnvironmentObject var viewModel: AppViewModel
    @EnvironmentObject var eventTasks: EventTasks
    @Environment(\.dismiss) var dismiss
    var event: Event
    
    @State private var eventRemoveAlert = false
    
    var body: some View {
        VStack{
            EventViewDetailed(event: event)
            HStack{
                NavigationLink(destination: AddTaskView(event: event)){
                    
                        ZStack{
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .fill(.teal)
                                .frame(height:50)
                                .padding()
                            Text("Add tasks")
                                .foregroundColor(.white)
                        }
                        
                    
                    
                }
                
                Button(action: {eventRemoveAlert.toggle()}){
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(.red)
                            .frame(height:50)
                            .padding()
                        Text("Remove event")
                            .foregroundColor(.white)
                    }
                        
                    
                    
                }
                .alert("You want to delete the event?", isPresented: $eventRemoveAlert) {
                    Button("Cancel", role: .cancel) { }
                    Button("Yes", role: .destructive) {
                        viewModel.removeEvent(event: event)
                        dismiss()
                    }
                }
            }
            
            
        }
        
    }
}

struct EventViewDetailedAdmin_Previews: PreviewProvider {
    static var previews: some View {
        EventViewDetailedAdmin(event: Event(name: "Name", startDate: Date(), endDate: Date(), isCharity: false))
    }
}
