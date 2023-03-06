//
//  BubblegumPresenting.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 01/12/22.
//

import Foundation
import AVFAudio

protocol BubblegumPresenting {
    var player: AVAudioPlayer { get }
    func initChallengeDownload() async
    func initializePlayer()
    func playAudio()
    func stopAudio()
    func forcePlayAudio()
    func pauseAudio()
}
