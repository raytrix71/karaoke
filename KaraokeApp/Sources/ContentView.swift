import SwiftUI

struct ContentView: View {
    @StateObject private var audioEngine = AudioEngineManager()
    @StateObject private var lyrics = LyricsManager()
    @State private var query: String = ""
    @State private var results: [String] = []

    var body: some View {
        VStack(spacing: 20) {
            Text("Karaoke Prototype")
                .font(.largeTitle)

            HStack {
                TextField("Search", text: $query)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Go") {
                    SpotifyManager.shared.search(query: query) { tracks in
                        results = tracks
                    }
                }
            }

            List(results, id: \.self) { track in
                Button(track) {
                    // Placeholder play action
                    lyrics.loadLyrics(for: track)
                    audioEngine.startSession()
                }
            }

            Text(lyrics.currentLine)
                .font(.title)
                .padding()

            HStack {
                Button("Stop") {
                    audioEngine.stopSession()
                }
            }
        }
        .onAppear {
            audioEngine.prepareEngine()
        }
    }
}

#Preview {
    ContentView()
}
