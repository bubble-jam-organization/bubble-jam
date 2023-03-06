//
//  BubblegumPresenter.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 01/12/22.
//

import Foundation
import AVFoundation

class BubblegumPresenter: NSObject, BubblegumPresenting {
    private(set) var currentChallenge: Challenge?
    var player: AVAudioPlayer
    var downloadAudioUseCase: DownloadAudioRoutineUseCase
    weak var viewDelegate: BubblegumViewDelegate?
    
    init(downloadAudioUseCase: DownloadAudioRoutineUseCase, player: AVAudioPlayer = AVAudioPlayer()) {
        self.downloadAudioUseCase = downloadAudioUseCase
        self.player = player
    }
    
    func initChallengeDownload() async {
        viewDelegate?.startLoading()
        await downloadAudioUseCase.execute()
    }
    
    func initializePlayer() {
        if let challenge = currentChallenge {
            do {
                let audioData = try Data(contentsOf: challenge.audio.path)
                player = try AVAudioPlayer(data: audioData, fileTypeHint: AVFileType.m4a.rawValue)
                player.numberOfLoops = 0
            } catch {
                print("Erro: \(error.localizedDescription)")
            }
        }
    }

    func playAudio() {
        if let challenge = currentChallenge {
            player.prepareToPlay()
            if player.play() { viewDelegate?.audioIsPlaying(challenge: challenge) }
        }
    }
    
    func forcePlayAudio() {
        player.prepareToPlay()
        player.play()
    }
    
    func stopAudio() {
        if player.isPlaying {
            player.stop()
        }
    }
    
    func pauseAudio() {
        if player.isPlaying {
            player.pause()
        }
    }
}

extension BubblegumPresenter: DownloadAudioRoutineOutput {
    
    func successfullyLoadChallenge(_ challenge: Challenge, date: Date) {
        currentChallenge = challenge
        let deadline = Calendar.current.dateComponents([.day], from: date, to: challenge.deadline)
        viewDelegate?.showChallenge(
            title: challenge.title,
            daysLeft: "\(String(describing: deadline.day!))"
        )
    }
    
    func failWhileLoadingChallenge(_ error: Error) {
        viewDelegate?.errorWhenLoadingChallenge(title: "Erro!", description: error.localizedDescription)
    }
}
