//
//  AssignTaskToUserView.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 10.04.2022.
//

import SwiftUI

struct AssignTaskToUserView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @EnvironmentObject var event: EventTasks
    var body: some View {
        VStack {
            Text("Assign task to")
                .bold()
                .font(.title)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            List {
                Section {
                    ForEach(viewModel.userList) { user in
                        HStack{
                            Text("\(user.name) \(user.lastName)")
                            Spacer()
                            Image(systemName: event.users.contains(user) ? "checkmark.circle" : "")
                                .foregroundColor(.blue)
                        }
                        .onTapGesture {
                            if event.users.contains(user){
                                if let index = event.users.firstIndex(of: user) {
                                    event.users.remove(at: index)
                                }
                            } else{
                                event.users.append(user)
                            }
                            print(event.users)
                        }
                    }
                  } header: {
                    Text("Users")
                  } footer: {
                    Text("\(viewModel.userList.count) users")
                  }
                
                    
                    
            }
                        
            
        }
        
        
        .navigationTitle("Assign task to")
        
    }
}

struct AssignTaskToUserView_Previews: PreviewProvider {
    static var previews: some View {
        AssignTaskToUserView()
    }
}
