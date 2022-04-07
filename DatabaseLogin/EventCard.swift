//
//  EventCard.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 07.04.2022.
//

import SwiftUI

struct EventCard: View {
    var event: Event
    var body: some View {
        VStack{
            Text(event.name)
                .font(.title2)
                .bold()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(4)
            Text("Start: \(event.startDate)")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .padding(4)
            Text("End: \(event.endDate)")
                .padding(4)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            if event.isCharity{
                Text("Target sum: \(event.charitySum)")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding(4)
                Text("*Charity event")
                    .font(.headline)
                    .foregroundColor(.green)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    
                    .padding(4)
            }
        }
        .foregroundColor(.secondary)
        .padding(8)
        .overlay(RoundedRectangle(cornerRadius: 30, style: .continuous).stroke(.teal, lineWidth: 2))
        .frame(maxWidth: .infinity)
        
    }
}

struct EventCard_Previews: PreviewProvider {
    static var previews: some View {
        EventCard(event: Event(name: "Name", startDate: "12/12/12", endDate: "13/12/12", isCharity: false))
    }
}