//
//  AudioService.swift
//  bubble-jam
//
//  Created by Otávio Albuquerque on 24/11/22.
//

import Foundation
import AVFoundation

struct AudioService: AudioServicing {
    private var audioUrl: URL!
    private var player: AVAudioPlayer?
    
    init(audioUrl: URL) {
        self.audioUrl = audioUrl
        self.player = try? AVAudioPlayer(contentsOf: audioUrl, fileTypeHint: AVFileType.m4a.rawValue)
    }
    
    func playSong() {
        guard let player = self.player else { return }
        player.play()
    }
}
