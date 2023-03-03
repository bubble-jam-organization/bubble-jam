//
//  DownloadAudioRoutineOutput.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 23/02/23.
//

import Foundation

protocol DownloadAudioRoutineOutput {
    func successfullyLoadChallenge(_ challenge: Challenge, date: Date)
    func failWhileLoadingChallenge(_ error: Error)
}
