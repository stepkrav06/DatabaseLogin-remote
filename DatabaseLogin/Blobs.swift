//
//  Blobs.swift
//  UIDatabase
//
//  Created by Степан Кравцов on 05.04.2022.
//

import Foundation
import SwiftUI
struct Blob1: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.964*width, y: 0.25602*height))
        path.addCurve(to: CGPoint(x: 0.228*width, y: 0.95109*height), control1: CGPoint(x: 1.148*width, y: 0.47011*height), control2: CGPoint(x: 0.57333*width, y: 1.19022*height))
        path.addCurve(to: CGPoint(x: 0.00267*width, y: 0.25602*height), control1: CGPoint(x: 0.11975*width, y: 0.95109*height), control2: CGPoint(x: -0.008*width, y: 0.56367*height))
        path.addCurve(to: CGPoint(x: 0.284*width, y: 0.06309*height), control1: CGPoint(x: 0.01333*width, y: -0.05163*height), control2: CGPoint(x: 0.19333*width, y: -0.02717*height))
        path.addCurve(to: CGPoint(x: 0.964*width, y: 0.25602*height), control1: CGPoint(x: 0.37467*width, y: 0.15335*height), control2: CGPoint(x: 0.78*width, y: 0.04194*height))
        path.closeSubpath()
        return path
    }
}
struct Blob2: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.99492*width, y: 0.47032*height))
        path.addCurve(to: CGPoint(x: 0.51186*width, y: 0.99772*height), control1: CGPoint(x: 1.03729*width, y: 0.73516*height), control2: CGPoint(x: 0.71593*width, y: 0.99772*height))
        path.addCurve(to: CGPoint(x: 0.00169*width, y: 0.29238*height), control1: CGPoint(x: 0.3078*width, y: 0.99772*height), control2: CGPoint(x: 0.00169*width, y: 0.55843*height))
        path.addCurve(to: CGPoint(x: 0.60678*width, y: 0.05251*height), control1: CGPoint(x: 0.00169*width, y: 0.02632*height), control2: CGPoint(x: 0.3661*width, y: -0.06393*height))
        path.addCurve(to: CGPoint(x: 0.99492*width, y: 0.47032*height), control1: CGPoint(x: 0.8678*width, y: 0.09132*height), control2: CGPoint(x: 0.95254*width, y: 0.20548*height))
        path.closeSubpath()
        return path
    }
}
struct Wave1: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0, y: 0.05344*height))
        path.addLine(to: CGPoint(x: 0.0275*width, y: 0.14333*height))
        path.addCurve(to: CGPoint(x: 0.16667*width, y: 0.39052*height), control1: CGPoint(x: 0.05583*width, y: 0.23322*height), control2: CGPoint(x: 0.11083*width, y: 0.413*height))
        path.addCurve(to: CGPoint(x: 0.33333*width, y: 0.12086*height), control1: CGPoint(x: 0.2225*width, y: 0.36805*height), control2: CGPoint(x: 0.2775*width, y: 0.14333*height))
        path.addCurve(to: CGPoint(x: 0.5*width, y: 0.27816*height), control1: CGPoint(x: 0.38917*width, y: 0.09839*height), control2: CGPoint(x: 0.44417*width, y: 0.27816*height))
        path.addCurve(to: CGPoint(x: 0.66667*width, y: 0.03097*height), control1: CGPoint(x: 0.55583*width, y: 0.27816*height), control2: CGPoint(x: 0.61083*width, y: 0.09839*height))
        path.addCurve(to: CGPoint(x: 0.83333*width, y: 0.14333*height), control1: CGPoint(x: 0.7225*width, y: -0.03644*height), control2: CGPoint(x: 0.7775*width, y: 0.0085*height))
        path.addCurve(to: CGPoint(x: 0.9725*width, y: 0.61524*height), control1: CGPoint(x: 0.88917*width, y: 0.27816*height), control2: CGPoint(x: 0.94417*width, y: 0.50288*height))
        path.addLine(to: CGPoint(x: width, y: 0.7276*height))
        path.addLine(to: CGPoint(x: width, y: 0.99727*height))
        path.addLine(to: CGPoint(x: 0.9725*width, y: 0.99727*height))
        path.addCurve(to: CGPoint(x: 0.83333*width, y: 0.99727*height), control1: CGPoint(x: 0.94417*width, y: 0.99727*height), control2: CGPoint(x: 0.88917*width, y: 0.99727*height))
        path.addCurve(to: CGPoint(x: 0.66667*width, y: 0.99727*height), control1: CGPoint(x: 0.7775*width, y: 0.99727*height), control2: CGPoint(x: 0.7225*width, y: 0.99727*height))
        path.addCurve(to: CGPoint(x: 0.5*width, y: 0.99727*height), control1: CGPoint(x: 0.61083*width, y: 0.99727*height), control2: CGPoint(x: 0.55583*width, y: 0.99727*height))
        path.addCurve(to: CGPoint(x: 0.33333*width, y: 0.99727*height), control1: CGPoint(x: 0.44417*width, y: 0.99727*height), control2: CGPoint(x: 0.38917*width, y: 0.99727*height))
        path.addCurve(to: CGPoint(x: 0.16667*width, y: 0.99727*height), control1: CGPoint(x: 0.2775*width, y: 0.99727*height), control2: CGPoint(x: 0.2225*width, y: 0.99727*height))
        path.addCurve(to: CGPoint(x: 0.0275*width, y: 0.99727*height), control1: CGPoint(x: 0.11083*width, y: 0.99727*height), control2: CGPoint(x: 0.05583*width, y: 0.99727*height))
        path.addLine(to: CGPoint(x: 0, y: 0.99727*height))
        path.addLine(to: CGPoint(x: 0, y: 0.05344*height))
        path.closeSubpath()
        return path
    }
}
