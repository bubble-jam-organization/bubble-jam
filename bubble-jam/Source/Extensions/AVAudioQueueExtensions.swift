//
//  AVAudioQueueExtensions.swift
//  bubble-jam
//
//  Created by Otávio Albuquerque on 24/11/22.
//

import Foundation
import AVFoundation

extension AVQueuePlayer {
    func isPlaying() -> Bool {
        if self.rate > 0 {
            return true
        }
        
        return false
    }
}
