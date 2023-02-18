//
//  AudioServiceSpy.swift
//  bubble-jamTests
//
//  Created by Thiago Henrique on 01/12/22.
//

import Foundation
@testable import bubble_jam

class AudioServiceSpy {
    private(set) var receivedMessages: [Message] = [Message]()
    var insertSongRaiseNonExistingAudioError: Bool = false
    var inserSongRaiseUnknownError: Bool = false

    enum Message: Equatable {
        case insertSong(String, String)
        case playSong
        case pauseSong
        
        var description: String {
            switch self {
                case .insertSong(let audioName, let audioFormat):
                    return "insertSong called with data: \(audioName).\(audioFormat)"
                case .playSong:
                    return "Playsong called"
                case .pauseSong:
                    return "Pause song called"
                
            }
        }
    }
}

extension AudioServiceSpy: AudioServicing {
    enum UnkwownError: Error {
        case unknown
    }
    
    func insertSong(songName: String, songFormat: String) throws {
        receivedMessages.append(.insertSong(songName, songFormat))
        if insertSongRaiseNonExistingAudioError { throw AudioServiceError.nonExistingAudio }
        if inserSongRaiseUnknownError { throw UnkwownError.unknown}
    }
    
    func playSong() {
        receivedMessages.append(.playSong)
    }
    
    func pauseSong() {
        receivedMessages.append(.pauseSong)
    }
}
