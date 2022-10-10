//
//  Colors.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 03.04.2022.
//

import Foundation
import SwiftUI

extension Color {
    static let background = Color("Background")
    static let textColor1 = Color("TextColor1")
    static let textColor2 = Color("TextColor2")
    static let lightGray = Color("LightGray")
    static let lightGray2 = Color("LightGray2")
    static let bg1 = Color("bg1")
    
}
let importanceColors = [Color.green, Color.yellow, Color.red]

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
