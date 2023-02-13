//
//  ExportGradesView.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 15.08.2022.
//

import SwiftUI
import Firebase
import Foundation

struct ExportGradesView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State var pickedEvents: [Event:Bool] = [:]
    @State var pickedUsers: [User:Bool] = [:]
    var body: some View {
        
            
                ScrollView {
                    VStack{
                        VStack{
                    Text("Events")
                        .font(.title)
                        .fontWeight(.thin)
                    ForEach(viewModel.eventList){event in
                        ZStack{
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .fill(pickedEvents[event] ?? false ? .green : .clear)
                                .frame(height: 50)
                                .padding(8)
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .stroke(pickedEvents[event] ?? false ? .clear : .textColor1)
                                .frame(height: 50)
                                .padding(8)
                            HStack{
                                Text(event.name)
                                    .foregroundColor(pickedEvents[event] ?? false ? .textColor2 : .textColor1)
                                if pickedEvents[event] ?? false{
                                    Image(systemName: "checkmark")
                                        .foregroundColor(pickedEvents[event] ?? false ? .textColor2 : .textColor1)
                                }
                            }
                        }
                        .onTapGesture {
                            if pickedEvents[event]!{
                                pickedEvents[event] = false
                            } else {
                                pickedEvents[event] = true
                            }
                        }
                    }
                }
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding()
                Spacer()
                
                    VStack{
                        Text("People")
                            .font(.title)
                            .fontWeight(.thin)
                        ForEach(viewModel.userList){user in
                            ZStack{
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .fill(pickedUsers[user] ?? false ? .green : .clear)
                                    .frame(height: 50)
                                    .padding(8)
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .stroke(pickedUsers[user] ?? false ? .clear : .textColor1)
                                    .frame(height: 50)
                                    .padding(8)
                                HStack{
                                    Text(user.name + " " + user.lastName)
                                        .foregroundColor(pickedUsers[user] ?? false ? .textColor2 : .textColor1)
                                    if pickedUsers[user] ?? false{
                                        Image(systemName: "checkmark")
                                            .foregroundColor(pickedUsers[user] ?? false ? .textColor2 : .textColor1)
                                    }
                                }
                            }
                            .onTapGesture {
                                if pickedUsers[user]!{
                                    pickedUsers[user] = false
                                } else {
                                    pickedUsers[user] = true
                                }
                            }
                        }
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding()
                    }
                }
                
        
            
        
        .navigationTitle("Export grades")
        .toolbar {
           
                Button(action: {
                    
                }){
                    NavigationLink(destination: ShareLoading(users: pickedUsers, events: pickedEvents)){
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(Color.textColor1)
                    }
                    
                    
                }
                
                
            
            
        }
        .onAppear{
            for event in viewModel.eventList{
                self.pickedEvents[event] = false
            }
            for user in viewModel.userList{
                self.pickedUsers[user] = false
            }
            
            
    }
    }
    
}

struct ExportGradesView_Previews: PreviewProvider {
    static var previews: some View {
        ExportGradesView()
    }
}
