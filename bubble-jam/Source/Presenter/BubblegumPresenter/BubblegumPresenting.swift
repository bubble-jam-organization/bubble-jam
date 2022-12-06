//
//  BubblegumPresenting.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 01/12/22.
//

import Foundation

protocol BubblegumPresenting {
    func initAudioDownload(in path: String?)
    func playAudio()
    func pauseAudio()
    func getAudioUrl() throws -> URL 
}
