//
//  Colors.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 03.04.2022.
//

import Foundation
import SwiftUI

extension Color {
    static let darkGr1 = Color("DarkGradient1")
    static let lightGr1 = Color("LightGradient1")
    static let darkGr2 = Color("DarkGradient2")
    static let lightGr2 = Color("LightGradient1")
    static let background = Color("Background")
    static let textColor1 = Color("TextColor1")
    static let textColor2 = Color("TextColor2")
    
}
let gradient1 = LinearGradient(gradient: Gradient(colors: [Color.darkGr1, Color.darkGr1.opacity(0.0)]), startPoint: .top, endPoint: .bottom)
let gradient2 = LinearGradient(gradient: Gradient(colors: [Color.darkGr2, Color.lightGr2]), startPoint: .topTrailing, endPoint: .bottomLeading)
let importanceColors = [Color.green, Color.yellow, Color.red]
