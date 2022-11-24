//
//  bubble-jamAudioServiceTests.swift
//  bubble-jamTests
//
//  Created by Otávio Albuquerque on 24/11/22.
//

import XCTest
@testable import bubble_jam
import AVFoundation

final class bubble_jamAudioServiceTests: XCTestCase {
    func test_insertSong_shouldInsertCorrectly() {
        let (sut,(player, bundle)) = makeSUT()
        
        do {
            try sut.insertSong(songName: "song", songFormat: "m4a")
        }catch AudioServiceError.nonExistingAudio {
            XCTFail("File not found :(")
        }catch {
            XCTFail("Error raised: \(error.localizedDescription) ")
        }
        
        let itemArray = [AVPlayerItem(url: bundle.url(forResource: "song", withExtension: "m4a")!)]
        XCTAssertEqual(getItemURL(itemArray.first), getItemURL(player.items().first))
        
    }
    
    func test_insertSong_notExistingSong() {
        let (sut, _) = makeSUT()
        
        do {
            try sut.insertSong(songName: "", songFormat: "")
            XCTFail("Sound shouldn't exist")
        } catch AudioServiceError.nonExistingAudio { } catch {
            XCTFail("Unexpected error raised \(error.localizedDescription)")
        }
    }
    
    func test_insertSong_shouldClearQueue() {
        let (sut, (player, bundle)) = makeSUT()
        let mockedSongs = createMockedSongs(on: bundle)
        
        player.insert(mockedSongs[0], after: nil)
        player.insert(mockedSongs[1], after: nil)
        
        let currentPlayerQueue = player.items()
        
        insertMockedSong(on: sut)
        
        XCTAssertNotEqual(currentPlayerQueue.count, player.items().count)
    }
    
    func test_playSong_shouldPlayCorrectly() {
        let (sut, (player, _)) = makeSUT()
        
        insertMockedSong(on: sut)
        
        sut.playSong()
        XCTAssertTrue(player.isPlaying())
    }
    
    func test_playSong_shouldNotPlay_ifThereIsNoItems() {
        let (sut, (player, _)) = makeSUT()
        
        sut.playSong()
        
        XCTAssertFalse(player.isPlaying())
    }
    
    func test_pauseSong_shouldPauseCorrectly() {
        let (sut, (player, _)) = makeSUT()
        
        insertMockedSong(on: sut)
        
        sut.playSong()
        sut.pauseSong()
        
        XCTAssertFalse(player.isPlaying())
    }
    
    func test_pauseSong_afterPause_shouldPlayAgain() {
        let (sut, (player, _)) = makeSUT()
        
        insertMockedSong(on: sut)
        
        sut.playSong()
        sut.pauseSong()
        sut.playSong()
        
        XCTAssertTrue(player.isPlaying())
    }
    
    func test_pauseSong_ifThereNotSong_shouldNotPause() {
        let (sut, (player, _)) = makeSUT()
        
        sut.pauseSong()
        
        XCTAssertFalse(player.isPlaying())
    }
    

}

extension bubble_jamAudioServiceTests: Testing {
    typealias SutAndDoubles = (AudioService,(AVQueuePlayer, Bundle))
    
    func makeSUT() -> SutAndDoubles {
        let player = AVQueuePlayer()
        let testBundle =  Bundle(for: type(of: self))
        let service = AudioService(player: player, bundle: testBundle)
        return (service, (player,testBundle))
    }
    
    func insertMockedSong(on sut: AudioService) {
        guard let _ = try? sut.insertSong(songName: "song", songFormat: "m4a") else {
            XCTFail("Insert song should not raised error")
            return
        }
    }

    func getItemURL(_ playerItem: AVPlayerItem?)  -> URL? {
        guard let asset = playerItem?.asset else {
            XCTFail("Asset nil")
            return nil
        }
        guard let urlasset = (asset as? AVURLAsset) else{
            XCTFail("NonExistant URLAsset")
            return nil
        }
        return urlasset.url
    }
    
    func createMockedSongs(on bundle: Bundle) -> [AVPlayerItem] {
        if let firstItemUrl = bundle.url(forResource: "song", withExtension: "m4a"),
           let secondItemUrl = bundle.url(forResource: "song2", withExtension: "m4a") {
            let firstItem = AVPlayerItem(url: firstItemUrl)
            let secondItem = AVPlayerItem(url: secondItemUrl)
            
            return [firstItem, secondItem]
        }
                
        XCTFail("Bundle url should not be nil!")
        return []
    }
    
}
