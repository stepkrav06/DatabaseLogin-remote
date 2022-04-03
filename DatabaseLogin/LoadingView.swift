//
//  LoadingView.swift
//  DatabaseLogin
//
//  Created by Степан Кравцов on 03.04.2022.
//

import SwiftUI

struct LoadingView: View {
    
    @State private var shouldAnimate = false
    
    var body: some View {
        VStack {
            
            HStack {
                Circle()
                    .fill(Color.textColor1)
                    .frame(width: 20, height: 20)
                    .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                    .animation(Animation.easeInOut(duration: 0.5).repeatForever(), value: shouldAnimate)
                Circle()
                    .fill(Color.textColor1)
                    .frame(width: 20, height: 20)
                    .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                    .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.3), value: shouldAnimate)
                Circle()
                    .fill(Color.textColor1)
                    .frame(width: 20, height: 20)
                    .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                    .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.6), value: shouldAnimate)
            }
            .onAppear {
                self.shouldAnimate = true
        }
           
        }
        .navigationTitle("Loading")
    }
    
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
