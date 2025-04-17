//
//  AudioPlayer.swift
//  WaveForm
//
//  Created by Sana on 17/04/2025.
//


import AVFoundation

class AudioPlayer: ObservableObject {
    private var player: AVAudioPlayer?
    private var timer: Timer?

    @Published var progress: Double = 0
    var duration: Double { player?.duration ?? 1 }

    func play(url: URL) {
        player = try? AVAudioPlayer(contentsOf: url)
        player?.prepareToPlay()
        player?.play()

        timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
            if let player = self.player {
                self.progress = player.currentTime / player.duration
            }
        }
    }

    func stop() {
        player?.stop()
        timer?.invalidate()
        timer = nil
    }
}
