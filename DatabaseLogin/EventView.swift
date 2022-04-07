//
//  EventView.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 05.04.2022.
//

import SwiftUI

struct EventView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State var showAddEvent: Bool = false
    @State var sortBy: String = "Date"
    var body: some View {
        ScrollView {
            VStack{
                VStack{
                    Text("Next coming event")
                        .bold()
                        .font(.title)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .padding(4)
                    EventNextUp(event: Event(name: "Name", startDate: "12/12/12", endDate: "13/12/12", isCharity: false))
                }
                .frame(maxWidth: .infinity)
                .foregroundColor(.primary)
                .padding()
                .background(.ultraThinMaterial)
                .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .background(RoundedRectangle(cornerRadius: 30, style: .continuous).stroke(.black, lineWidth: 1).blur(radius: 4))
                
                .padding()
                HStack{
                    Picker("Sort by", selection: $sortBy) {
                                    Text("Date")
                    
                            .tag("Date")
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
                ForEach(viewModel.eventList){ event in
                    EventCard(event: event)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                }
                Spacer()
                    .frame(height: 100)
            }.navigationTitle("Events")
        }
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView()
    }
}
