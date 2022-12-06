//
//  BubblegumPresenterTest.swift
//  bubble-jamTests
//
//  Created by Thiago Henrique on 01/12/22.
//

import XCTest
@testable import bubble_jam

final class BubblegumPresenterTest: XCTestCase {
    func test_loadAudio_should_insertSong_and_play() {
        let (sut, doubles) = makeSUT()
        sut.playAudio()
        XCTAssertEqual(doubles.audioServiceSpy.receivedMessages, [.insertSong("song", "m4a"), .playSong])
    }

//    func test_loadAudio_whenFail_should_callDelegateNonExistError() {
//        let (sut, doubles) = makeSUT()
//        doubles.serviceSpy.insertSongRaiseNonExistingAudioError = true
//        sut.loadAudio()
//        XCTAssertEqual(doubles.delegateSpy.receivedMessages, [.errorWhenLoadingAudio("Erro!", "Não foi possível encontrar o áudio!")])
//    }
//
//    func test_loadAudio_whenFail_should_callDelegateUnkwownError() {
//        let (sut, doubles) = makeSUT()
//        doubles.serviceSpy.inserSongRaiseUnknownError = true
//        sut.loadAudio()
//        XCTAssertEqual(doubles.delegateSpy.receivedMessages, [.errorWhenLoadingAudio("Erro!", "Error desconhecido, reinicie o aplicativo e tente novamente!")])
//    }

//    func test_loadAudio_whenSuccess_shouldCall_delegateCorrectly() {
//        let (sut, doubles) = makeSUT()
//        sut.loadAudio()
//        let mockedData = Audio(
//            data: Data(),
//            localAudioName: "song",
//            format: .m4a,
//            details: AudioDetails(notes: [], description: "Lorem ipsum", bpm: 0)
//        )
//        XCTAssertEqual(doubles.delegateSpy.receivedMessages, [.audioHasBeenLoaded(mockedData)])
//    }
    
//    func test_playAudio_should_playAudioCorrectly() {
//        let (sut, doubles) = makeSUT()
//        sut.playAudio()
//        XCTAssertEqual(doubles.serviceSpy.receivedMessages, [.playSong])
//    }
    
    func test_pauseAudio_should_pauseAudioCorrectly() {
        let (sut, doubles) = makeSUT()
        sut.pauseAudio()
        XCTAssertEqual(doubles.audioServiceSpy.receivedMessages, [.pauseSong])
    }
}

extension BubblegumPresenterTest: Testing {
    typealias SutAndDoubles = (
        sut: BubblegumPresenter,
        doubles: (
            audioServiceSpy: AudioServiceSpy,
            downloadServicespy: DownloadServiceSpy,
            delegateSpy: BubblegumViewDelegateSpy
        )
    )
    
    func makeSUT() -> SutAndDoubles {
        let audioServiceSpy = AudioServiceSpy()
        let downloadServiceSpy = DownloadServiceSpy()
        let delegateSpy = BubblegumViewDelegateSpy()
        let sut = BubblegumPresenter(audioService: audioServiceSpy, downloadService: downloadServiceSpy)
        sut.viewDelegate = delegateSpy
        return (sut, (audioServiceSpy, downloadServiceSpy, delegateSpy))
    }
}
