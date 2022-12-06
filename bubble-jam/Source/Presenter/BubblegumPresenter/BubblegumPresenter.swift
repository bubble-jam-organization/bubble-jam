//
//  BubblegumPresenter.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 01/12/22.
//

import Foundation

class BubblegumPresenter: BubblegumPresenting {
    let audioService: AudioServicing
    let downloadService: DownloadServicing
    weak var viewDelegate: BubblegumViewDelegate?
    
    private var mockedAudio = Audio(
        data: Data(),
        localAudioName: "song",
        format: .m4a,
        details: AudioDetails(notes: [], description: "Lorem ipsum", bpm: 130)
    )
    
    init(audioService: AudioServicing, downloadService: DownloadServicing) {
        self.audioService = audioService
        self.downloadService = downloadService
    }
    
    func initAudioDownload(in path: String?) {
        viewDelegate?.startLoading()
        viewDelegate?.audioHasBeenLoaded()
//        do {
//            try downloadService.downloadAudio(
//                audioName: audio.localAudioName!,
//                audioExtension: audio.format.rawValue
//            )
//            try audioService.insertSong(songName: audio.localAudioName!, songFormat: audio.format.rawValue)
//            viewDelegate?.audioHasBeenLoaded()
//        } catch {
//            print(error.localizedDescription)
//        }
    }
    
    func playAudio() {
        do {
            try audioService.insertSong(
                songName: mockedAudio.localAudioName!,
                songFormat: mockedAudio.format.rawValue
            )
            audioService.playSong()
            viewDelegate?.audioIsPlaying(mockedAudio)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func pauseAudio() {
        audioService.pauseSong()
    }
    
    func getAudioUrl() -> URL {
        return downloadService.loadTmpPathUrl()
    }
}
