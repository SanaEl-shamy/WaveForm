//
//  WaveView.swift
//  WaveForm
//
//  Created by Sana on 17/04/2025.
//

import SwiftUI
struct WaveView: View {
    @State private var phase: CGFloat = 0

    var body: some View {
        WaveShape(phase: phase, amplitude: 20)
            .stroke(Color.blue, lineWidth: 2)
            .frame(height: 100)
            .onAppear {
                withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                    phase = .pi * 2
                }
            }
    }
}
#Preview {
    WaveView()
}
