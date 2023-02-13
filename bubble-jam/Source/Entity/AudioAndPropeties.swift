//
//  AudioAndPropeties.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 07/02/23.
//

import Foundation

struct AudioAndPropeties: Equatable {
    let path: URL
    let format: String
    let notes: [String]
    let bpm: UInt
}
