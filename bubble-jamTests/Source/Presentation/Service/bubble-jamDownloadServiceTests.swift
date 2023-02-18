//
//  bubble-jamDownloadServiceTests.swift
//  bubble-jamTests
//
//  Created by Otávio Albuquerque on 25/11/22.
//

import XCTest
@testable import bubble_jam

final class bubble_jamDownloadServiceTests: XCTestCase {
    private var manager: FileManager!
    
    enum Constants: String {
        case testPath = "tempTest/"
        case songName = "song"
        case songExtension = "m4a"
    }
    
    var destinationUrl: URL {
        let documentsDirectoryURL = manager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationURL = documentsDirectoryURL.appending(path: Constants.testPath.rawValue)
        return destinationURL
    }

    override func setUp() {
        manager = FileManager()
        XCTAssertNoThrow(try manager.createDirectory(at: destinationUrl, withIntermediateDirectories: false))
    }
    
    override func tearDown() {
        if manager.fileExists(atPath: destinationUrl.path()) {
            XCTAssertNoThrow(try manager.removeItem(atPath: destinationUrl.path()))
        }
    }

    func test_downloadAudio_shouldDownload() {
        let (sut, (manager, _)) = makeSUT()
        XCTAssertNoThrow(
            try sut.downloadAudio(
                audioName: Constants.songName.rawValue,
                audioExtension: Constants.songExtension.rawValue
            )
        )
        let fileName = "\(Constants.songName.rawValue).\(Constants.songExtension.rawValue)"
        let url = destinationUrl.appendingPathComponent(fileName)
  
        XCTAssertTrue(manager.fileExists(atPath: url.path()))
    }
    
    func test_downloadAudio_fileShouldNotExist() {
        let (sut, _) = makeSUT()
        XCTAssertThrowsError(try sut.downloadAudio(audioName: "a", audioExtension: "a")) { error in
            XCTAssertNotNil(error as? DownloadServiceError)
            XCTAssertEqual(error as? DownloadServiceError, .fileNotExists )
        }
        
    }
    
    func test_downloadAudio_fileShouldAlreadyExist() {
        let (sut, _) = makeSUT()
        try? sut.downloadAudio(
            audioName: Constants.songName.rawValue,
            audioExtension: Constants.songExtension.rawValue
        )
        XCTAssertThrowsError(try sut.downloadAudio(
            audioName: Constants.songName.rawValue,
            audioExtension: Constants.songExtension.rawValue)) { error in
                XCTAssertNotNil(error as? DownloadServiceError)
                XCTAssertEqual(error as? DownloadServiceError, .fileAlreadyExists)
            }
        
    }
    
//    func test_createDirectory_shouldCreateDir() {
//        let (sut, _) = makeSUT()
//        let testFolderURL = destinationUrl.appending(path: "folderTeste")
//        do {
//            try sut.downloadAudio(
//                audioName: Constants.songName.rawValue,
//                audioExtension: Constants.songExtension.rawValue,
//                folderPath: Constants.testPath.rawValue + "folderTeste"
//            )
//            XCTAssertTrue(manager.fileExists(atPath: testFolderURL.path()))
//        } catch {
//            XCTFail(error.localizedDescription)
//        }
//    }
//
    func test_loadSandboxAudio_shouldLoadCorrectly() {
        let (sut, (manager, bundle)) = makeSUT()
        XCTAssertNoThrow(
            try sut.downloadAudio(
                audioName: Constants.songName.rawValue,
                audioExtension: Constants.songExtension.rawValue
            )
        )
        XCTAssertNoThrow(try sut.loadSandboxAudio())
    }
}

extension bubble_jamDownloadServiceTests: Testing {
    typealias SutAndDoubles = (DownloadService, (FileManager, Bundle))
    
    func makeSUT() -> SutAndDoubles {
        let testBundle = Bundle(for: type(of: self))
        let service = DownloadService(manager: self.manager, bundle: testBundle, folderPath: Constants.testPath.rawValue)
        return (service, (manager, testBundle))
    }

}
