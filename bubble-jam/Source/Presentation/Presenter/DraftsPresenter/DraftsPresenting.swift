//
//  DraftsPresenting.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 17/02/23.
//

import Foundation

protocol DraftsPresenting {
    func uploadJam(draft: Draft) async
    func downloadJam(for challenge: Challenge) async
    func playAudio(draft: Draft)
    func stopAudio()
}
