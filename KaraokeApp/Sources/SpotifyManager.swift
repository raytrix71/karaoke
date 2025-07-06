import Foundation

/// Lightweight wrapper around Spotify App Remote and Web APIs.
final class SpotifyManager {
    static let shared = SpotifyManager()

    func connect() {
        // TODO: Implement authentication and app remote connection
    }

    func search(query: String, completion: @escaping ([String]) -> Void) {
        // TODO: Call Spotify search API and return track identifiers
        completion([])
    }

    func play(uri: String) {
        // TODO: Send play command to Spotify App Remote
    }

    func pause() {
        // TODO: Send pause command
    }
}
