//
//  BubblegumPresenter.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 01/12/22.
//

import Foundation

class BubblegumPresenter: BubblegumPresenting {
    let service: AudioServicing
    weak var viewDelegate: BubblegumViewDelegate?
    
    init(service: AudioServicing) {
        self.service = service
    }
    
    func playAudio() {
        service.playSong()
    }
    
    func pauseAudio() {
        service.pauseSong()
    }
    
    func loadAudio() {
        let audio = Audio(
            data: Data(),
            localAudioName: "song",
            format: .m4a,
            details: AudioDetails(notes: [], description: "Lorem ipsum", bpm: 0)
        )
        
        do {
            try service.insertSong(songName: audio.localAudioName!, songFormat: audio.format.rawValue) // TODO remover audio mockado por audio com Data
            viewDelegate?.audioHasBeenLoaded(audio)
        } catch {
            if error is AudioServiceError {
                viewDelegate?.errorWhenLoadingAudio(
                    title: "Erro!",
                    description: error.localizedDescription
                )
                return
            }
            
            viewDelegate?.errorWhenLoadingAudio(
                title: "Erro!",
                description: AudioServiceError.unkwownError.localizedDescription
            )
        }
    }
}
