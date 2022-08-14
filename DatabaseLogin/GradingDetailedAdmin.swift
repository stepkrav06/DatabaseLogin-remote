//
//  GradingDetailedAdmin.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 14.08.2022.
//

import SwiftUI
import Firebase

struct GradingDetailedAdmin: View {
    var event: Event
    @EnvironmentObject var viewModel: AppViewModel
    @State var grades: [String:Grade] = [:]
    var body: some View {
        ScrollView{
        VStack(spacing: 0){
            Text("Users")
                .font(.body)
                .fontWeight(.thin)
                .italic()
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.top)
                .padding(.horizontal)
            RoundedRectangle(cornerRadius: 50, style: .continuous)
                .frame(height: 1)
                .padding(.top, 4)
                .padding(.horizontal)
            ForEach(viewModel.userList){user in
                
                NavigationLink(destination: EmptyView()){
                    ZStack{
                        if grades[user.uid]?.activity != ""{
                            
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.teal)
                                .frame(height: 60)
                                .opacity(0.3)
                                .padding(.horizontal)
                        }
                        HStack(spacing: 5){
                        Image(systemName: "person.circle")
                            .foregroundColor(.black)
                            .font(.largeTitle)
                            
                        VStack(alignment: .leading, spacing: 5){
                            Text(user.name + " " + user.lastName)
                                .foregroundColor(Color.black)
                            if Int(user.grade) != nil{
                            Text("Grade " + user.grade)
                                .foregroundColor(Color.secondary)
                            } else {
                                Text(user.grade)
                                    .foregroundColor(Color.secondary)
                            }
                           
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        if grades[user.uid]?.activity != ""{
                            if grades[user.uid]?.attendance == false{
                                HStack{
                                    Image(systemName: "person.fill.xmark")
                                        .foregroundColor(.black)
                                    Text("Absent")
                                        .fontWeight(.thin)
                                        .foregroundColor(.black)
                                }
                                .padding(.trailing, 32)
                            }
                            else if grades[user.uid]?.attendance == true{
                                HStack{
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.black)
                                    Text("Graded")
                                        .fontWeight(.thin)
                                        .foregroundColor(.black)
                                }
                                .padding(.trailing, 32)
                            }
                        }
                            else {
                                HStack{
                                    Image(systemName: "xmark")
                                        .foregroundColor(.black)
                                    Text("Ungraded")
                                        .fontWeight(.thin)
                                        .foregroundColor(.black)
                                }
                                .padding(.trailing, 32)
                            }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)
                    }
                    .frame(height: 60)
                }
                RoundedRectangle(cornerRadius: 50, style: .continuous)
                    .frame(height: 1)
                    .padding(.horizontal)
            }
        }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .navigationTitle("Grading " + event.name)
        .onAppear{
            let ref = Database.database().reference(withPath: "grades")
            for user in viewModel.userList{
                
            
                ref.child(user.uid).child(event.sid).observeSingleEvent(of: .value, with: { snapshot in
                // 3
                
                  // 4
                    
                      
                     
                        let grade = Grade(snapshot: snapshot)
                        grades[user.uid] = grade!
                        
                  
                
                }) { (error) in
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct GradingDetailedAdmin_Previews: PreviewProvider {
    static var previews: some View {
        GradingDetailedAdmin(event: Event(name: "Event name", startDate: Date(), endDate: Date(), isCharity: false))
    }
}
