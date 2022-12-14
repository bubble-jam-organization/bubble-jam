//
//  Audio.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 01/12/22.
//

import Foundation

struct Audio: Equatable {
    
    let data: Data
    let localAudioName: String?
    let format: AudioFormat
    let details: AudioDetails
    
    static func == (lhs: Audio, rhs: Audio) -> Bool {
        return lhs.data == rhs.data &&
        lhs.localAudioName == rhs.localAudioName &&
        lhs.format == rhs.format &&
        lhs.details == rhs.details
    }
}

struct AudioDetails: Equatable {
    let notes: [Note]?
    let description: String?
    let bpm: Int
}

enum Note: String {
    case A
    case Bb
    case B
    case C
    case Db
    case D
    case Eb
    case E
    case F
    case Gb
    case G
    case Ab
}

enum AudioFormat: String {
    case m4a
    case mp3
    case unkwown
    
    init(rawValue: String) {
        switch rawValue {
            case "m4a":
                self = .m4a
            case "mp3":
                self = .mp3
            default:
                self = .unkwown
        }
    }
}
