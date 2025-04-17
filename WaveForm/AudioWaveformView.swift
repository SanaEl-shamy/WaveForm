//
//  AudioWaveformView.swift
//  WaveForm
//
//  Created by Sana on 17/04/2025.
//
import SwiftUI

struct AudioWaveformView: View {
    var amplitudes: [Float]

    var body: some View {
        GeometryReader { geo in
            let height = geo.size.height
            let width = geo.size.width / CGFloat(amplitudes.count)

            HStack(alignment: .center, spacing: 1) {
                ForEach(amplitudes.indices, id: \.self) { index in
                    let amp = CGFloat(amplitudes[index])
                    Capsule()
                        .frame(width: width, height: max(1, amp * height))
                        .foregroundColor(.blue)
                }
            }
        }
    }
}
