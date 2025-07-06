import Foundation
import Combine

/// Manages synchronized lyrics for the currently playing track.
final class LyricsManager: ObservableObject {
    @Published var currentLine: String = ""
    private var lyrics: [TimeInterval: String] = [:]

    /// Loads lyrics for a track given its identifier.
    func loadLyrics(for trackID: String) {
        // TODO: Fetch and parse synchronized lyrics
        lyrics = [:]
    }

    /// Updates the currently displayed lyric line based on playback time.
    func update(at time: TimeInterval) {
        // Simple nearest lookup placeholder
        let line = lyrics.sorted { abs($0.key - time) < abs($1.key - time) }.first
        currentLine = line?.value ?? ""
    }
}
