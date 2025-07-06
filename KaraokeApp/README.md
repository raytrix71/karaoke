# KaraokeApp

Prototype cross-platform Karaoke application for iOS and macOS.
This demo shows the basic structure of the audio pipeline and UI
without implementing the full Spotify or Core ML logic.

## Features
- Connect to Spotify (Premium required)
- Display synchronized lyrics
- Real-time vocal attenuation using Core ML or DSP fallback
- Capture microphone and mix with instrumental track
- Output audio to speakers or headphones

## Building
This package is a Swift Package for demonstration purposes only.
Open the project in Xcode 15 or later and run on an iOS or macOS target.
Actual Spotify authentication and vocal attenuation require additional
setup that is beyond the scope of this repository.
