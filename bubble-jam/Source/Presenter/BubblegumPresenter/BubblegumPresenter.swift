//
//  BubblegumPresenter.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 01/12/22.
//

import Foundation

class BubblegumPresenter: BubblegumPresenting {
    let service: AudioService
    weak var viewDelegate: BubblegumViewDelegate?
    
    init(service: AudioService) {
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
            try service.insertSong(songName: audio.localAudioName ?? "song", songFormat: audio.format.rawValue) // TODO remover audio mockado por audio com Data
            service.playSong()
        } catch {
            print(error)
        }
        
        viewDelegate?.audioHasBeenLoaded(audio)
    }
}
