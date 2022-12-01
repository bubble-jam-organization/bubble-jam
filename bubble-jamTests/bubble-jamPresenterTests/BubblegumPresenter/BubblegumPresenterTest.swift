//
//  BubblegumPresenterTest.swift
//  bubble-jamTests
//
//  Created by Thiago Henrique on 01/12/22.
//

import XCTest
@testable import bubble_jam

final class BubblegumPresenterTest: XCTestCase {
    func test_loadAudio_should_insertSongOnService() {
        let (sut, doubles) = makeSUT()
        sut.loadAudio()
        XCTAssertEqual(doubles.serviceSpy.receivedMessages, [.insertSong("song", "m4a")])
    }
    
    func test_loadAudio_whenFail_should_callDelegateNonExistError() {
        let (sut, doubles) = makeSUT()
        doubles.serviceSpy.insertSongRaiseNonExistingAudioError = true
        sut.loadAudio()
        XCTAssertEqual(doubles.delegateSpy.receivedMessages, [.errorWhenLoadingAudio("Erro!", "Não foi possível encontrar o áudio!")])
    }
    
    func test_loadAudio_whenFail_should_callDelegateUnkwownError() {
        let (sut, doubles) = makeSUT()
        doubles.serviceSpy.inserSongRaiseUnknownError = true
        sut.loadAudio()
        XCTAssertEqual(doubles.delegateSpy.receivedMessages, [.errorWhenLoadingAudio("Erro!", "Error desconhecido, reinicie o aplicativo e tente novamente!")])
    }

    func test_loadAudio_whenSuccess_shouldCall_delegateCorrectly() {
        let (sut, doubles) = makeSUT()
        sut.loadAudio()
        let mockedData = Audio(
            data: Data(),
            localAudioName: "song",
            format: .m4a,
            details: AudioDetails(notes: [], description: "Lorem ipsum", bpm: 0)
        )
        XCTAssertEqual(doubles.delegateSpy.receivedMessages, [.audioHasBeenLoaded(mockedData)])
    }
    
    func test_playAudio_should_playAudioCorrectly() {
        let (sut, doubles) = makeSUT()
        sut.playAudio()
        XCTAssertEqual(doubles.serviceSpy.receivedMessages, [.playSong])
    }
    
    func test_pauseAudio_should_pauseAudioCorrectly() {
        let (sut, doubles) = makeSUT()
        sut.pauseAudio()
        XCTAssertEqual(doubles.serviceSpy.receivedMessages, [.pauseSong])
    }
}

extension BubblegumPresenterTest: Testing {
    typealias SutAndDoubles = (
        sut: BubblegumPresenter,
        doubles: (
            serviceSpy: AudioServiceSpy,
            delegateSpy: BubblegumViewDelegateSpy
        )
    )
    
    func makeSUT() -> SutAndDoubles {
        let serviceSpy = AudioServiceSpy()
        let delegateSpy = BubblegumViewDelegateSpy()
        let sut = BubblegumPresenter(service: serviceSpy)
        sut.viewDelegate = delegateSpy
        return (sut, (serviceSpy, delegateSpy))
    }
}
