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
    private(set) var player: AVAudioPlayer!
    var downloadAudioUseCase: DownloadAudioRoutineUseCase
    weak var viewDelegate: BubblegumViewDelegate?
    
    init(
        downloadAudioUseCase: DownloadAudioRoutineUseCase,
        player: AVAudioPlayer = AVAudioPlayer()
    ) {
        self.downloadAudioUseCase = downloadAudioUseCase
        self.player = player
    }
    
    func initChallengeDownload() async {
        viewDelegate?.startLoading()
        await downloadAudioUseCase.execute()
    }

    func playAudio() {
        if let challenge = currentChallenge {
            do {
                let audioData = try Data(contentsOf: challenge.audio.path)
                AVAudioSession.sharedInstance()
                player = try AVAudioPlayer(data: audioData, fileTypeHint: AVFileType.m4a.rawValue)
                player.delegate = self
                player.numberOfLoops = 0
                player.prepareToPlay()
                if player.play() { viewDelegate?.audioIsPlaying(challenge: challenge) }
            } catch {
                print("Erro: \(error.localizedDescription)")
            }
        }
    }
    
    func stopAudio() {
        if let player = player, player.isPlaying {
            player.stop()
        }
    }
}

extension BubblegumPresenter: AVAudioPlayerDelegate {}

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
