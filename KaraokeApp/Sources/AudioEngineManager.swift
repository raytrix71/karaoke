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
    private var micTapInstalled = false
    var microphoneBufferHandler: ((AVAudioPCMBuffer, AVAudioTime) -> Void)?

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
        if !micTapInstalled, let micInput {
            micInput.installTap(onBus: 0, bufferSize: 1024, format: micInput.inputFormat(forBus: 0)) { [weak self] buffer, time in
                self?.microphoneBufferHandler?(buffer, time)
            }
            micTapInstalled = true
        }
        do {
            try engine.start()
        } catch {
            print("Engine start error: \(error)")
        }
    }

    func stopSession() {
        engine.stop()
        if micTapInstalled, let micInput {
            micInput.removeTap(onBus: 0)
            micTapInstalled = false
        }
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
