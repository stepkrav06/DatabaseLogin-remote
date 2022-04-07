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
            Text("Start: \(event.startDate.formatted(date: .abbreviated, time: .omitted))")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .padding(4)
            Text("End: \(event.endDate.formatted(date: .abbreviated, time: .omitted))")
                .padding(4)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            if event.isCharity{
                Text("Target sum: \(event.charitySum)")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding(4)
                Text("*Charity event")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    
                    .padding(4)
            }
        }
        .foregroundColor(.primary)
        .padding()
        .background(Color.teal.opacity(0.8))
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .background(RoundedRectangle(cornerRadius: 30, style: .continuous).stroke(.black, lineWidth: 2).blur(radius: 5))
        .frame(maxWidth: .infinity)
        
    }
}

struct EventCard_Previews: PreviewProvider {
    static var previews: some View {
        EventCard(event: Event(name: "Name", startDate: Date(), endDate: Date()
                               , isCharity: false))
    }
}
