//
//  RealAudioRecorder.swift
//  WaveForm
//
//  Created by Sana on 17/04/2025.
//


import AVFoundation

class RealAudioRecorder: ObservableObject {
    private var recorder: AVAudioRecorder?
    private var timer: Timer?

    @Published var amplitudes: [Float] = []

    func startRecording() {
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(.playAndRecord, mode: .default)
        try? session.setActive(true)

        let url = getAudioFileURL()
        let settings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        recorder = try? AVAudioRecorder(url: url, settings: settings)
        recorder?.isMeteringEnabled = true
        recorder?.prepareToRecord()
        recorder?.record()

        // تحديث الموجة كل 0.05 ثانية
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            self.recorder?.updateMeters()
            let level = self.recorder?.averagePower(forChannel: 0) ?? -160
            let normalized = self.normalize(level: level)
            self.amplitudes.append(normalized)
            if self.amplitudes.count > 100 {
                self.amplitudes.removeFirst()
            }
        }
    }

    func stopRecording() {
        recorder?.stop()
        timer?.invalidate()
        timer = nil
    }

    func getAudioFileURL() -> URL {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return dir.appendingPathComponent("recorded_audio.m4a")
    }

    private func normalize(level: Float) -> Float {
        // تحويل مستوى الصوت إلى قيمة بين 0 و 1
        let minLevel: Float = -80
        let maxLevel: Float = 0
        let clamped = max(min(level, maxLevel), minLevel)
        return (clamped - minLevel) / (maxLevel - minLevel)
    }
    
    func deleteRecording() {
        let url = getAudioFileURL()
        try? FileManager.default.removeItem(at: url)
        amplitudes.removeAll()
    }

}
