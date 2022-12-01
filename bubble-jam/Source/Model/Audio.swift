//
//  Audio.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 01/12/22.
//

import Foundation

struct Audio {
    let data: Data
    let localAudioName: String?
    let format: AudioFormat
    let details: AudioDetails
}

struct AudioDetails {
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
}
