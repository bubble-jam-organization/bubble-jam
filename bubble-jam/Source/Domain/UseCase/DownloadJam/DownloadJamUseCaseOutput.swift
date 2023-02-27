//
//  DownloadJamUseCaseOutput.swift
//  bubble-jam
//
//  Created by Caio Soares on 24/02/23.
//

import Foundation

protocol DownloadJamUseCaseOutput {
    func sucessfullyDownloadJams(_ jam: Draft)
    func failWhileDownloadingJam(_ error: Error)
}
