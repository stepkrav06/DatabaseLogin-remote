//
//  EventView.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 05.04.2022.
//

import SwiftUI

struct EventView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State var showAddEvent: Bool = false
    var body: some View {
        VStack{
            Button(action: {showAddEvent.toggle()}){
                Text("Add event")
            }
            .sheet(isPresented: $showAddEvent){
                AddEventPage ()
            }
        }.navigationTitle("Events")
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView()
    }
}
