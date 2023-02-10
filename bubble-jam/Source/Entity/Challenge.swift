//
//  Challenge.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 07/02/23.
//

import Foundation

struct Challenge: Equatable {
    let title: String
    let description: String
    let rules: [String]
    let initialDate: Date
    let deadline: Date
    let audio: AudioAndPropeties
}
