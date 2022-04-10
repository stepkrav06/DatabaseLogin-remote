//
//  AssignTaskToUserView.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 10.04.2022.
//

import SwiftUI

struct AssignTaskToUserView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State var isEditing = true
    @State var selection = Set<String>()
    var body: some View {
        VStack {
            List(selection: $selection) {
                Section {
                    ForEach(viewModel.userList) { user in
                        
                        Text("\(user.name) \(user.lastName)")
                    }
                  } header: {
                    Text("Users")
                  } footer: {
                      Text("\(viewModel.userList.count) users")
                  }
                        }
                        
                        .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive))
                        Button(action: {
                            print(selection)
                        }) {
                            Text(isEditing ? "Done" : "Edit")
                                .frame(width: 80, height: 40)
                        }
                        .background(Color.yellow)
                    }
        .navigationTitle("Assign task to")
        
    }
}

struct AssignTaskToUserView_Previews: PreviewProvider {
    static var previews: some View {
        AssignTaskToUserView()
    }
}
