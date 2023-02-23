//
//  BubblegumPresenter.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 01/12/22.
//

import Foundation
import AVFoundation

class BubblegumPresenter: BubblegumPresenting {    
    var downloadAudioUseCase: DownloadAudioRoutineUseCase
    weak var viewDelegate: BubblegumViewDelegate?
    private(set) var currentChallenge: Challenge?
    
    init(downloadAudioUseCase: DownloadAudioRoutineUseCase) {
        self.downloadAudioUseCase = downloadAudioUseCase
    }
    
    func initChallengeDownload() async {
        viewDelegate?.startLoading()
        await downloadAudioUseCase.execute()
    }

    func playAudio() {
        if let challenge = currentChallenge {
            do {
                let player = try AVAudioPlayer(contentsOf: challenge.audio.path, fileTypeHint: AVFileType.m4a.rawValue)
                player.prepareToPlay()
                player.numberOfLoops = 1
                if player.play() { viewDelegate?.audioIsPlaying(challenge.audio) }
            } catch {
                print("Erro: \(error.localizedDescription)")
            }
        }
    }
}

extension BubblegumPresenter: DownloadAudioRoutineOutput {
    func successfullyLoadChallenge(_ challenge: Challenge) {
        currentChallenge = challenge
        let deadline = Calendar.current.dateComponents([.day], from: Date.now, to: challenge.deadline)
        viewDelegate?.showChallenge(
            title: challenge.title,
            daysLeft: "\(String(describing: deadline.day!))"
        )
    }
    
    func failWhileLoadingChallenge(_ error: Error) {
        viewDelegate?.errorWhenLoadingChallenge(title: "Erro!", description: error.localizedDescription)
    }
}
