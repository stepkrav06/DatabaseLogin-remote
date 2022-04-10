//
//  TabViewAdmin.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 01.04.2022.
//

import SwiftUI

struct TabViewAdmin: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State var selectedTab: TabAdmin = .event
    @State var color: Color = .teal
    @State private var offsetX: CGFloat = 0.0
    @State private var offsetY: CGFloat = 0.0
    @State private var n: Int = 0
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom){
                Group{
                    switch selectedTab{
                    case .event:
                        EventViewAdmin()
                    case .fundraiser:
                        SomeView()
                    case .grading:
                        SomeView()
                    case .account:
                        AccountViewAdmin()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                if !viewModel.isWriting{
                    HStack{
                        ForEach(tabItemsAdmin) { item in
                            Button(action: {
                                n = 1
                                    selectedTab = item.tab
                                    color = item.color
                                
                                
                            }) {
                                VStack(spacing: 0){
                                    Image(systemName: item.icon)
                                        .symbolVariant(.fill)
                                        .font(.body.bold())
                                        .frame(width: 44, height: 29)
                                    Text(item.text)
                                        .font(.caption2)
                                        .lineLimit(1)
                                }
                                .frame(maxWidth: .infinity)
                            }
                            .foregroundStyle(selectedTab == item.tab ? .primary : .secondary)
                            .blendMode(selectedTab == item.tab ? .overlay : .normal)
                        }
                    }
                    .padding(.horizontal, 8)
                    .padding(.top, 14)
                    .frame(height: 88, alignment: .top)
                    .background(.ultraThinMaterial, in:
                                    RoundedRectangle(cornerRadius: 34, style: .continuous))
                    .opacity(1)
                    .background(
                        GeometryReader { geomReader in
                            HStack{
                                if selectedTab == .event { Circle().fill(color).frame(width: 88).position(x: offsetX, y: offsetY)
                                        .onAppear {
                                            
                                            if n != 0 {
                                                withAnimation(.spring(response: 0.2, dampingFraction: 0.7)){
                                                    self.offsetX = geomReader.size.width / 8 - 5
                                                    self.offsetY =  geomReader.size.height / 2
                                                }
                                            }
                                                    }
                                    
                                }
                                if selectedTab == .fundraiser { Circle().fill(color).frame(width: 88).position(x: offsetX, y: offsetY)
                                        .onAppear {
                                            withAnimation(.spring(response: 0.2, dampingFraction: 0.7)){
                                                self.offsetX = geomReader.size.width / 8 * 3 - 7
                                                self.offsetY =  geomReader.size.height / 2
                                            }
                                                    } }
                                if selectedTab == .grading {
                                    Circle().fill(color).frame(width: 88).position(x: offsetX, y: offsetY)
                                        .onAppear {
                                            withAnimation(.spring(response: 0.2, dampingFraction: 0.7)){
                                                self.offsetX = geomReader.size.width / 8 * 5 - 9
                                                self.offsetY =  geomReader.size.height / 2
                                            }
                                                    }
                                }
                                
                                if selectedTab == .account { Circle().fill(color).frame(width: 88).position(x: offsetX, y: offsetY)
                                        .onAppear {
                                            withAnimation(.spring(response: 0.2, dampingFraction: 0.7)){
                                                self.offsetX = geomReader.size.width / 8 * 7 - 11
                                                self.offsetY =  geomReader.size.height / 2
                                            }
                                                    } }
                                
                            }
                            .padding(.horizontal, 8)
                        }
                    )
                    .overlay(
                        GeometryReader { geomReader in
                            HStack{
                                if selectedTab == .event { Rectangle()
                                        .fill(color)
                                        .frame(width: 28, height: 5)
                                        .cornerRadius(3)
                                        .frame(width: 88)
                                        .frame(maxHeight: .infinity, alignment: .top)
                                        .position(x: offsetX, y: offsetY)
                                        .onAppear {
                                            if n != 0 {
                                                withAnimation(.spring(response: 0.2, dampingFraction: 0.7)){
                                                    self.offsetX = geomReader.size.width / 8 - 5
                                                    self.offsetY =  geomReader.size.height / 2
                                                }
                                            }
                                            else{
                                                DispatchQueue.main.async {
                                                    self.offsetX = geomReader.size.width / 8 - 5
                                                    self.offsetY =  geomReader.size.height / 2
                                                }
                                                
                                            }

                                                    }
                                }
                                if selectedTab == .fundraiser { Rectangle()
                                        .fill(color)
                                        .frame(width: 28, height: 5)
                                        .cornerRadius(3)
                                        .frame(width: 88)
                                        .frame(maxHeight: .infinity, alignment: .top)
                                        .position(x: offsetX, y: offsetY)
                                        .onAppear {
                                            withAnimation(.spring(response: 0.2, dampingFraction: 0.7)){
                                                self.offsetX = geomReader.size.width / 8 * 3 - 7
                                                self.offsetY =  geomReader.size.height / 2
                                            }
                                                    }
                                        
                                }
                                if selectedTab == .grading {
                                    Rectangle()
                                            .fill(color)
                                            .frame(width: 28, height: 5)
                                            .cornerRadius(3)
                                            .frame(width: 88)
                                            .frame(maxHeight: .infinity, alignment: .top)
                                            .position(x: offsetX, y: offsetY)
                                            .onAppear {
                                                withAnimation(.spring(response: 0.2, dampingFraction: 0.7)){
                                                    self.offsetX = geomReader.size.width / 8 * 5 - 9
                                                    self.offsetY =  geomReader.size.height / 2
                                                }
                                                        }
                                    
                                }
                                if selectedTab == .account { Rectangle()
                                        .fill(color)
                                        .frame(width: 28, height: 5)
                                        .cornerRadius(3)
                                        .frame(width: 88)
                                        .frame(maxHeight: .infinity, alignment: .top)
                                        .position(x: offsetX, y: offsetY)
                                        .onAppear {
                                            withAnimation(.spring(response: 0.2, dampingFraction: 0.7)){
                                                self.offsetX = geomReader.size.width / 8 * 7 - 11
                                                self.offsetY =  geomReader.size.height / 2
                                            }
                                                    } }
                                
                            }
                            .padding(.horizontal, 8)
                        }
                    )
                }
                
                
                
                
            }
            
            
        }
        
    }
}

struct TabViewAdmin_Previews: PreviewProvider {
    static var previews: some View {
        TabViewAdmin()
    }
}
