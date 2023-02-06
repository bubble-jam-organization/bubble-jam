//
//  AudioServicing.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 01/12/22.
//

import Foundation

protocol AudioServicing {
    func insertSong(songName: String, songFormat: String) throws
    func playSong()
    func pauseSong()
}
