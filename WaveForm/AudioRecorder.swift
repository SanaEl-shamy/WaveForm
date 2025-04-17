//
//  AudioRecorder.swift
//  WaveForm
//
//  Created by Sana on 17/04/2025.
//


import AVFoundation

class AudioRecorder: ObservableObject {
    private var engine = AVAudioEngine()
    private var inputNode: AVAudioInputNode?
    private let bus = 0
    
    @Published var amplitudes: [Float] = []

    func startRecording() {
        inputNode = engine.inputNode
        let format = inputNode!.inputFormat(forBus: bus)

        inputNode?.installTap(onBus: bus, bufferSize: 1024, format: format) { buffer, _ in
            self.processAudioBuffer(buffer: buffer)
        }

        try? engine.start()
    }

    func stopRecording() {
        inputNode?.removeTap(onBus: bus)
        engine.stop()
    }

    private func processAudioBuffer(buffer: AVAudioPCMBuffer) {
        guard let channelData = buffer.floatChannelData?[0] else { return }
        let frameLength = Int(buffer.frameLength)

        var maxAmplitude: Float = 0
        for i in 0..<frameLength {
            let sample = channelData[i]
            maxAmplitude = max(maxAmplitude, abs(sample))
        }

        DispatchQueue.main.async {
            self.amplitudes.append(maxAmplitude)
            if self.amplitudes.count > 100 {
                self.amplitudes.removeFirst()
            }
        }
    }
}
