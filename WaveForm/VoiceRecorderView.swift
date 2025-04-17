//
//  VoiceRecorderView.swift
//  WaveForm
//
//  Created by Sana on 17/04/2025.
//

import SwiftUI
struct VoiceRecorderView: View {
    @StateObject var recorder = AudioRecorder()

    var body: some View {
        VStack {
            AudioWaveformView(amplitudes: recorder.amplitudes)
                .frame(height: 100)
                .padding()

            HStack {
                Button("Start") {
                    recorder.startRecording()
                }
                Button("Stop") {
                    recorder.stopRecording()
                }
                Button("🗑 Delete") {
                    recorder.deleteRecording()
                }
            }
        }
    }
}
