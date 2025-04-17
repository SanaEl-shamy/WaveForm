//
//  PlaybackWaveformView.swift
//  WaveForm
//
//  Created by Sana on 17/04/2025.
//


struct PlaybackWaveformView: View {
    var amplitudes: [Float]
    var progress: Double

    var body: some View {
        GeometryReader { geo in
            let totalWidth = geo.size.width
            let height = geo.size.height
            let barWidth = totalWidth / CGFloat(amplitudes.count)

            HStack(alignment: .center, spacing: 1) {
                ForEach(amplitudes.indices, id: \.self) { index in
                    let amp = CGFloat(amplitudes[index])
                    Capsule()
                        .fill(index < Int(progress * Double(amplitudes.count)) ? Color.green : Color.gray)
                        .frame(width: barWidth, height: max(1, amp * height))
                }
            }
        }
    }
}
