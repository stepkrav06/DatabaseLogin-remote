//
//  AddEventPage.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 07.04.2022.
//

import SwiftUI

struct AddEventPage: View {
    @State private var name: String = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var isCharity: Bool = false
    @FocusState private var writingFocus: Bool
    @State private var eventAddedAlertSuccess = false
    
    @EnvironmentObject var viewModel: AppViewModel
    var body: some View {
        
        ZStack{
            VStack{
                Spacer()
                Image(systemName: "calendar")
                    .font(.system(size: 100))
                VStack {
                    TextField(
                        "Name",
                        text: $name
                    )
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .focused($writingFocus)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    
                    DatePicker("Start date", selection: $startDate, displayedComponents: .date)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    DatePicker("End date", selection: $endDate, displayedComponents: .date)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    Toggle("Charity", isOn: $isCharity)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    
                }
                
                
                Button(action: {
                    writingFocus = false
                    guard !name.isEmpty else{
                        return
                    }
                    let event = Event(name: name, startDate: startDate.formatted(), endDate: endDate.formatted(), isCharity: isCharity)
                    viewModel.addEvent(event: event)
                    eventAddedAlertSuccess = true
                    
                }){
                    Text("Add user")
                }
                .foregroundColor(.white)
                .padding()
                .background(.orange)
                .cornerRadius(8)
                .alert("Event added", isPresented: $eventAddedAlertSuccess) {
                    Button("OK", role: .cancel) { }
                }
                Spacer()
                
                Spacer()
//                Button(action: {
//                    AddUser()
//
//                }){
//                    Text("Add user")
//                }
//                .foregroundColor(.white)
//                .padding()
//                .background(.orange)
//                .cornerRadius(8)
//                ForEach(userList.users) { user in
//                    Text(user.name)
//                }
            }
            .navigationTitle("Add event")
            
            
        }
        
    }
}

struct AddEventPage_Previews: PreviewProvider {
    static var previews: some View {
        AddEventPage()
    }
}