//
//  TaskViewCard.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 10.08.2022.
//

import SwiftUI

struct TaskViewCard: View {
    var taskName: String
    var taskDescription: String
    var importance: String
    var numPeople: String
    var body: some View {
        ZStack{
            ZStack {
                RoundedRectangle(cornerRadius: 35, style: .continuous)
                    .fill(.white)
                HStack {
                    RoundedRectangle(cornerRadius: 40, style: .continuous)
                        .fill(importanceColors[Int(importance)!-1])
                    .frame(maxWidth: 8, maxHeight: 80, alignment: .leading)
                    .padding(.bottom,20)
                    
                    Spacer()
                        .frame(maxWidth: 20)
                    VStack(alignment: .leading) {
                        Text(taskName)
                            .foregroundColor(.black)
                            .font(.title)
                            .fontWeight(.medium)
                        Spacer()
                            .frame(maxHeight: 10)
                        Text(taskDescription)
                            .foregroundColor(.black)
                            .font(.body)
                            .fontWeight(.light)
                    }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .padding(20)
                    HStack(spacing:2) {
                        Image(systemName: "person")
                            .frame(alignment:.bottom)
                        
                        Text(numPeople)
                            .fontWeight(.light)
                    }.frame(maxHeight: .infinity, alignment: .bottomTrailing)
                        .padding()
                        .padding(.horizontal)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                
            }
            .frame(minHeight: 160, maxHeight:200)
            .padding()
        }
        
        
    }
}

struct TaskViewCard_Previews: PreviewProvider {
    static var previews: some View {
        TaskViewCard(taskName: "Task", taskDescription: "Description", importance: "3", numPeople: "5")
    }
}
