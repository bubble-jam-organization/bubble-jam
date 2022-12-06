//
//  AudioService.swift
//  bubble-jam
//
//  Created by Otávio Albuquerque on 24/11/22.
//

import Foundation
import AVFoundation

struct AudioService: AudioServicing {
    private var player: AVQueuePlayer!
    private var bundle: Bundle!
    
    init(player: AVQueuePlayer = AVQueuePlayer(), bundle: Bundle = Bundle.main) {
        self.player = player
        self.bundle = bundle
    }
    
    func insertSong(songName: String, songFormat: String) throws {
        clearSongQueue()
        if let song = bundle.url(forResource: songName, withExtension: songFormat) {
            let audioSong = AVPlayerItem(url: song)
            player.insert(audioSong, after: nil)
            return
        }
        throw AudioServiceError.nonExistingAudio
    }
    
    private func clearSongQueue() {
        player.removeAllItems()
    }
    
    func playSong() {
        if !player.items().isEmpty {
            player.play()
        }
    }
    
    func pauseSong() {
        if player.isPlaying() {
            player.pause()
        }
    }
    
}
