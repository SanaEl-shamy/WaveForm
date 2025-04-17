//
//  WaveShape.swift
//  WaveForm
//
//  Created by Sana on 17/04/2025.
//


import SwiftUI

struct WaveShape: Shape {
    var phase: CGFloat
    var amplitude: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height

        let midHeight = height / 2
        let waveLength: CGFloat = width / 10

        path.move(to: CGPoint(x: 0, y: midHeight))

        for x in stride(from: 0, through: width, by: 1) {
            let relativeX = x / waveLength
            let y = amplitude * sin(relativeX + phase) + midHeight
            path.addLine(to: CGPoint(x: x, y: y))
        }

        return path
    }

    var animatableData: CGFloat {
        get { phase }
        set { phase = newValue }
    }
}
//
//#Preview {
//    WaveShape()
//}
