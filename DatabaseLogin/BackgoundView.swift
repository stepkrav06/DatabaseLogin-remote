//
//  ContentView.swift
//  UIDatabase
//
//  Created by Степан Кравцов on 05.04.2022.
//

import SwiftUI

struct BackgoundView: View {
    var body: some View {
        ZStack {
            ZStack {
                Blob1()
                    .frame(width: 450, height: 250)
                    .foregroundColor(Color.pink.opacity(0.5))
                .offset(x: 100, y: -200)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .blur(radius: 20)
                
                Blob1()
                    .frame(width: 400, height: 200)
                    .foregroundColor(Color.orange.opacity(0.5))
                .offset(x: 100, y: -200)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .blur(radius: 10)
                Blob2()
                    .frame(width: 250, height: 250)
                    .foregroundColor(Color.pink.opacity(0.4))
                .offset(x: -150, y: -300)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .blur(radius: 10)
                Blob2()
                    .frame(width: 200, height: 200)
                    .foregroundColor(Color.orange.opacity(0.4))
                .offset(x: -150, y: -300)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .blur(radius: 10)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            .background(LinearGradient(colors: [.purple, .blue], startPoint: .top, endPoint: .bottom))
        .overlay(Material.ultraThinMaterial)
        .overlay(Color.black.opacity(0.15).ignoresSafeArea())
            Wave1()
                .frame(width: 1000, height: 300)
                .foregroundColor(Color.purple.opacity(0.3))
                .offset(x: -220, y: 100)
                .blur(radius: 20)
            Wave1()
                .frame(width: 1000, height: 300)
                .foregroundColor(Color.purple.opacity(0.5))
                .offset(x: -160, y: 200)
                .blur(radius: 20)
            Wave1()
                .frame(width: 1000, height: 300)
                .foregroundColor(Color.purple.opacity(0.5))
                .offset(x: -100, y: 300)
                .blur(radius: 15)
        }
        
    }
}

struct BackgoundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgoundView()
    }
}
