//
//  AudioAndPropeties.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 07/02/23.
//

import Foundation

struct AudioAndPropeties: Equatable {
    let path: URL
    let format: AudioFormat
    let notes: [Note]
    let bpm: UInt
}

struct AudioDetails: Equatable {
    let notes: [Note]?
    let description: String?
    let rules: [String]
    let bpm: Int
}

enum Note: String {
    case A = "a"
    case Bb = "a#"
    case B = "b"
    case C = "c"
    case Db = "c#"
    case D = "d"
    case Eb = "d#"
    case E = "e"
    case F = "f"
    case Gb = "f#"
    case G = "g"
    case Ab = "g#"
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
