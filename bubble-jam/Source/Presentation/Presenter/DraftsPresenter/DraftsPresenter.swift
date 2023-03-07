//
//  DraftsPresenter.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 17/02/23.
//

import Foundation
import AVFoundation

class DraftsPresenter: DraftsPresenting {
    
    private var uploadJamUseCase: any UploadJamUseCaseProtocol
    private var downloadChallengeJamUseCase: any DownloadJamUseCaseProtocol
    
    private var player: AVAudioPlayer!
    weak var viewDelegate: DraftViewDelegate?
    
    init(
        uploadJamUseCase: any UploadJamUseCaseProtocol,
        downloadChallengeJamUseCase: any DownloadJamUseCaseProtocol,
        player: AVAudioPlayer = AVAudioPlayer()
    ) {
        self.uploadJamUseCase = uploadJamUseCase
        self.downloadChallengeJamUseCase = downloadChallengeJamUseCase
        self.player = player
    }
    
    func uploadJam(draft: Draft) async {
        viewDelegate?.startLoading()
        uploadJamUseCase.input = draft
        await uploadJamUseCase.execute()
        viewDelegate?.hideLoading()
    }
    
    func downloadJam(for challenge: Challenge) async {
        viewDelegate?.startLoading()
        downloadChallengeJamUseCase.input = challenge
        await downloadChallengeJamUseCase.execute()
        viewDelegate?.hideLoading()
    }
    
    func playAudio(draft: Draft) {
        do {
            let audioData = try Data(contentsOf: draft.audio)
            player = try AVAudioPlayer(data: audioData, fileTypeHint: AVFileType.m4a.rawValue)
            player.numberOfLoops = 0
            player.prepareToPlay()
            player.play()
        } catch {
            print("Erro: \(error.localizedDescription)")
        }
    }
    
    func stopAudio() {
        if let player = player, player.isPlaying {
            player.stop()
        }
    }
    
}

extension DraftsPresenter: UploadJamUseCaseOutput {
    func successfulyUploadJam(_ jam: Draft) {
        viewDelegate?.succesfullyUploadDraft(jam)
    }
    
    func failWhileUploadingJam(_ error: Error) {
        viewDelegate?.failWhileUploadingDraft(error)
    }
}

extension DraftsPresenter: DownloadJamUseCaseOutput {
    func sucessfullyDownloadJams(_ jam: Draft) {
        viewDelegate?.draftHasBeenDownloaded(jam)
    }
    
    func failWhileDownloadingJam(_ error: Error) {
        viewDelegate?.failWhileDownloadingDraft(error)
    }
}
