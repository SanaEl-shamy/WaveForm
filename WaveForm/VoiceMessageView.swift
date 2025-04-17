//
//  VoiceMessageView.swift
//  WaveForm
//
//  Created by Sana on 17/04/2025.
//

import SwiftUI

struct VoiceMessageView: View {
    @StateObject var recorder = RealAudioRecorder()
    @StateObject var player = AudioPlayer()

    var body: some View {
        VStack(spacing: 20) {
            // Wave أثناء التسجيل
            if player.progress == 0 {
                AudioWaveformView(amplitudes: recorder.amplitudes)
                    .frame(height: 80)
            } else {
                // Wave أثناء التشغيل
                PlaybackWaveformView(amplitudes: recorder.amplitudes, progress: player.progress)
                    .frame(height: 80)
            }

            HStack(spacing: 30) {
                Button("🎙️ Start Recording") {
                    recorder.startRecording()
                }
                Button("⏹ Stop") {
                    recorder.stopRecording()
                }
                Button("▶️ Play") {
                    let url = recorder.getAudioFileURL()
                    player.play(url: url)
                }
            }
        }
        .padding()
    }
}
