//
//  EventView.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 05.04.2022.
//

import SwiftUI

struct EventViewAdmin: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    @State var showAddEvent: Bool = false
    @State var sortBy: String = "Start Date"
    var body: some View {
        ScrollView {
            if viewModel.eventList.count == 0{
                VStack{
                    Text("No events yet")
                    Button(action: {showAddEvent.toggle()}){
                        Image(systemName: "plus")
                            .font(.system(size: 30))
                            .padding(4)
                            .foregroundColor(.secondary)
                        
                            .background(.black.opacity(0.1))
                            .mask(
                                Circle()
                            )
                            
                            
                    }
                    .padding(.horizontal)
                    .sheet(isPresented: $showAddEvent){
                        AddEventPage ()
                    }
                }
            }
            else{
            
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
                    
                Button(action: {showAddEvent.toggle()}){
                    Image(systemName: "plus")
                        .font(.system(size: 30))
                        .padding(4)
                        .foregroundColor(.secondary)
                    
                        .background(.black.opacity(0.1))
                        .mask(
                            Circle()
                        )
                        
                        
                }
                .padding(.horizontal)
                .sheet(isPresented: $showAddEvent){
                    AddEventPage ()
                }
                }
                if sortBy == "Start Date"{
                    
                ForEach(viewModel.eventList.sorted(by: {
                    $0.startDate.compare($1.startDate) == .orderedAscending
                })){ event in
                    NavigationLink(destination: EventViewDetailedAdmin(event: event)){
                    EventCard(event: event)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        
                    }
                }
                }
                if sortBy == "End Date"{
                    
                ForEach(viewModel.eventList.sorted(by: {
                    $0.startDate.compare($1.startDate) == .orderedDescending
                })){ event in
                    NavigationLink(destination: EventViewDetailedAdmin(event: event)){
                    EventCard(event: event)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        
                    }
                        
                        
                }
                }
                if sortBy == "Name"{
                    ForEach(viewModel.eventList.sorted { $0.name.lowercased() < $1.name.lowercased() }){ event in
                        NavigationLink(destination: EventViewDetailedAdmin(event: event)){
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
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventViewAdmin()
    }
}
