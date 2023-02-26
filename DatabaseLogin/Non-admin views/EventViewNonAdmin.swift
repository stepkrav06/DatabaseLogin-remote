//
//  EventViewNonAdmin.swift
//
//  The event page for regular users
//
//

import SwiftUI

struct EventViewNonAdmin: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    @State var showAddEvent: Bool = false
    @State var sortBy: String = "Start Date"
    var body: some View {
        ScrollView {
            VStack{
                NextUpMeetingView()
                HStack{
                    Picker("Sort by", selection: $sortBy) {
                                    Text("Start Date")
                    
                            .tag("Start Date")
                        Text("End Date")
        
                .tag("End Date")
                                    Text("Name")
                            
                            .tag("Name")
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                .padding()
                    
                
                }
                // sorting by start date (default)
                if sortBy == "Start Date"{
                    
                ForEach(viewModel.eventList.sorted(by: {
                    $0.startDate.compare($1.startDate) == .orderedAscending
                })){ event in
                    NavigationLink(destination: EventViewDetailed(event: event)){
                    EventCard(event: event)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        
                    }
                }
                }
                // sorting by end date
                if sortBy == "End Date"{
                    
                ForEach(viewModel.eventList.sorted(by: {
                    $0.startDate.compare($1.startDate) == .orderedDescending
                })){ event in
                    NavigationLink(destination: EventViewDetailed(event: event)){
                    EventCard(event: event)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        
                    }
                        
                        
                }
                }
                // sorting by name
                if sortBy == "Name"{
                    ForEach(viewModel.eventList.sorted { $0.name.lowercased() < $1.name.lowercased() }){ event in
                        NavigationLink(destination: EventViewDetailed(event: event)){
                        EventCard(event: event)
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            
                        }
                            
                            
                    }
                }
                Spacer()
                    .frame(height: 100)
            }.navigationTitle("Events")
        }
    }
}

struct EventViewNonAdmin_Previews: PreviewProvider {
    static var previews: some View {
        EventViewNonAdmin()
    }
}
