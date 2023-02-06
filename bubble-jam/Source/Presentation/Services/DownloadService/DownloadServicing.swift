//
//  DownloadServicing.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 02/12/22.
//

import Foundation

protocol DownloadServicing {
    func downloadAudio(audioName: String, audioExtension: String) throws
    func loadSandboxAudio() throws -> Audio
    func loadAudioUrl(_ name: String, _ format: String) throws -> URL
}
