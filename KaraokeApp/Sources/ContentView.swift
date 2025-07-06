import SwiftUI

struct ContentView: View {
    @StateObject private var audioEngine = AudioEngineManager()

    var body: some View {
        VStack {
            Text("Karaoke Prototype")
                .font(.largeTitle)
            Button(action: {
                audioEngine.startSession()
            }) {
                Text("Start")
            }
            .padding()
            Button(action: {
                audioEngine.stopSession()
            }) {
                Text("Stop")
            }
            .padding()
        }
        .onAppear {
            audioEngine.prepareEngine()
        }
    }
}

#Preview {
    ContentView()
}
