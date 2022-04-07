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
    @State private var charitySum: String = "0"
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
                    if isCharity{
                        TextField(
                            "Charity goal",
                            text: $charitySum
                        )
                        .keyboardType(.numberPad)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    }
                }
                
                
                Button(action: {
                    guard !name.isEmpty else{
                        return
                    }
                    if isCharity{
                        let event = Event(name: name, startDate: startDate.formatted(date: .abbreviated, time: .omitted) , endDate: endDate.formatted(date: .abbreviated, time: .omitted), isCharity: isCharity, charitySum: charitySum)
                        viewModel.addEvent(event: event)
                        eventAddedAlertSuccess = true
                    } else {
                        let event = Event(name: name, startDate: startDate.formatted(date: .abbreviated, time: .omitted) , endDate: endDate.formatted(date: .abbreviated, time: .omitted), isCharity: isCharity)
                        viewModel.addEvent(event: event)
                        eventAddedAlertSuccess = true
                    }
                    
                    
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
