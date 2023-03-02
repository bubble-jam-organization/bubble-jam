//
//  BubblegumPresenting.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 01/12/22.
//

import Foundation

protocol BubblegumPresenting {
    func initChallengeDownload() async
    func playAudio()
    func stopAudio()
    func forcePlayAudio()
    func pauseAudio()
    func audioDuration() -> String?
}
