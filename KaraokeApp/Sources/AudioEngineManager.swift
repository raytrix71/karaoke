import AVFoundation
import Combine

final class AudioEngineManager: ObservableObject {
    private let engine = AVAudioEngine()
    private var micInput: AVAudioInputNode? { engine.inputNode }
    private let mixer = AVAudioMixerNode()

    func prepareEngine() {
        engine.attach(mixer)
        engine.connect(micInput!, to: mixer, format: micInput!.inputFormat(forBus: 0))
        engine.connect(mixer, to: engine.mainMixerNode, format: micInput!.inputFormat(forBus: 0))
    }

    func startSession() {
        do {
            try engine.start()
        } catch {
            print("Engine start error: \(error)")
        }
    }

    func stopSession() {
        engine.stop()
    }
}
