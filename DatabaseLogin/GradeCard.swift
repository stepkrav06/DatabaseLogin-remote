//
//  GradeCard.swift
//
//  Cards with event information for the grading page
//
//

import SwiftUI

struct GradeCard: View {
    var admin: Bool
    var event: Event
    var icon: String {
        if admin {
            return "magazine"
        } else {
            return "chart.bar"
        }
    }
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 30, style: .continuous).stroke(.black, lineWidth: 2)
                .blur(radius: 5)
                .frame(height: 100)
                .padding(20)
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(.teal)
                .frame(height: 100)
                .padding(20)
            HStack{
                VStack(alignment: .leading, spacing: 10){
                    Text(event.name)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.black)
                    Text(event.startDate.formatted(.dateTime .day(.defaultDigits).month(.defaultDigits).year(.defaultDigits).locale(Locale(identifier: "ru"))) + " - " + event.endDate.formatted(.dateTime .day(.defaultDigits).month(.defaultDigits).year(.defaultDigits).locale(Locale(identifier: "ru"))))
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding()
                .padding(.leading, 24)
                ZStack{
                    Circle()
                        .fill(.white)
                        .frame(width: 40, height: 40)
                    Image(systemName: icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.black)
                }
                .padding()
                .padding(.trailing, 24)
            }
            
        }
        
    }
}

struct GradeCard_Previews: PreviewProvider {
    static var previews: some View {
        GradeCard(admin: true, event: Event(name: "Event name", startDate: Date(), endDate: Date(), isCharity: false))
    }
}
