import AVFoundation
import Combine

/// Handles audio capture, mixing and playback for the Karaoke app.
/// Vocal attenuation is performed on the player output before it is
/// mixed with the microphone input.

final class AudioEngineManager: ObservableObject {
    private let engine = AVAudioEngine()
    private var micInput: AVAudioInputNode? { engine.inputNode }
    private let player = AVAudioPlayerNode()
    private let mixer = AVAudioMixerNode()
    private let attenuator = VocalAttenuator()

    /// Configures the audio engine graph with microphone and player nodes.
    func prepareEngine() {
        engine.attach(player)
        engine.attach(mixer)

        if let micInput {
            engine.connect(micInput, to: mixer, format: micInput.inputFormat(forBus: 0))
        }
        engine.connect(player, to: mixer, format: nil)
        engine.connect(mixer, to: engine.mainMixerNode, format: nil)
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

    /// Plays a buffer through the vocal attenuator and player node.
    func play(buffer: AVAudioPCMBuffer) {
        let processed = attenuator.process(buffer)
        player.scheduleBuffer(processed, at: nil, options: [], completionHandler: nil)
        if !player.isPlaying {
            player.play()
        }
    }
}
