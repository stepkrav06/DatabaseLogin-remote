//
//  BlurView.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 01.04.2022.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
    var effect: UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: effect))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
    
}


