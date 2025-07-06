import Foundation
#if canImport(SpotifyiOS)
import SpotifyiOS
#endif

/// Lightweight wrapper around Spotify App Remote and Web APIs.
/// Actual authentication details must be supplied by the app.
final class SpotifyManager: NSObject {
    static let shared = SpotifyManager()

#if canImport(SpotifyiOS)
    private var appRemote: SPTAppRemote?
    private var sessionManager: SPTSessionManager?
#endif

    func connect(clientID: String, redirectURL: URL) {
#if canImport(SpotifyiOS)
        let configuration = SPTConfiguration(clientID: clientID, redirectURL: redirectURL)
        let manager = SPTSessionManager(configuration: configuration, delegate: nil)
        sessionManager = manager
        manager.initiateSession(with: [.appRemoteControl], options: .default)
        appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
#endif
    }

    func search(query: String, token: String, completion: @escaping ([String]) -> Void) {
        guard let url = URL(string: "https://api.spotify.com/v1/search?q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&type=track&limit=10") else {
            completion([])
            return
        }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let tracks = ((json["tracks"] as? [String: Any])?["items"] as? [[String: Any]]) else {
                completion([])
                return
            }
            let uris = tracks.compactMap { $0["uri"] as? String }
            completion(uris)
        }.resume()
    }

    func play(uri: String) {
#if canImport(SpotifyiOS)
        appRemote?.playerAPI?.play(uri, callback: nil)
#endif
    }

    func pause() {
#if canImport(SpotifyiOS)
        appRemote?.playerAPI?.pause(nil)
#endif
    }
}
