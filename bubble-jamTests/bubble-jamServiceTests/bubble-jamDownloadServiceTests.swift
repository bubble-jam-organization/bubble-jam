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

    func test_fetchAudio_shouldDownload() {
        let (sut, (manager, _)) = makeSUT()
        XCTAssertNoThrow(
            try sut.fetchAudio(
                audioName: Constants.songName.rawValue,
                audioExtension: Constants.songExtension.rawValue,
                folderPath: Constants.testPath.rawValue
            )
        )
        let fileName = "\(Constants.songName.rawValue).\(Constants.songExtension.rawValue)"
        let url = destinationUrl.appendingPathComponent(fileName)
  
        XCTAssertTrue(manager.fileExists(atPath: url.path()))
    }
    
    //
    //    func test_downloadAudio_shouldDownload() {
    //        let (service, (manager, _)) = makeSUT()
    //        clearState(with: manager)
    //        let expectation = XCTestExpectation(description: "Should download audio successfully")
    //
    //        service.downloadAudio(audioName: "song", audioExtension: "m4a") { [weak self] result in
    //            switch result {
    //                case .success(let url):
    //                    let path =  url.path()
    //                    let hasFile = manager.fileExists(atPath: path)
    //                    XCTAssertTrue(hasFile)
    //                    expectation.fulfill()
    //                case .failure(let error):
    //                    XCTFail("Download audio should not raise error, but: \(error.localizedDescription)")
    //            }
    //        }
    //
    //        wait(for: [expectation], timeout: 3)
    //    }
    //
    //    func test_downloadAudio_shouldRaise_fileNotExistError() {
    //        let (service, (manager, _)) = makeSUT()
    //        clearState(with: manager)
    //        let expectation = XCTestExpectation(description: "Should raise error")
    //
    //        service.downloadAudio(audioName: "song", audioExtension: "m4a") { result in
    //            switch result {
    //                case .success(let url):
    //                    XCTFail("Method download audio should raise fileNotExist error")
    //                    self?.clearAddedItems(with: manager, on: url.path())
    //                case .failure(let error):
    //                    if let downloadError = error as? DownloadServiceError, downloadError == .fileNotExists {
    //                        expectation.fulfill()
    //                    } else {
    //                        XCTFail("Wrong error was raised: \(error.localizedDescription)")
    //                    }
    //            }
    //        }
    //        wait(for: [expectation], timeout: 3)
    //    }
    
}

extension bubble_jamDownloadServiceTests: Testing {
    typealias SutAndDoubles = (DownloadService, (FileManager, Bundle))
    
    func makeSUT() -> SutAndDoubles {
        let testBundle = Bundle(for: type(of: self))
        let service = DownloadService(manager: self.manager, bundle: testBundle)
        return (service, (manager, testBundle))
    }
    //
    //    func clearState(with manager: FileManager) {
    //        let documentPath = manager.urls(for: .documentDirectory, in: .userDomainMask).first!
    //        let filePath = documentPath.appending(path: "")
    //
    //        if let fileExists = try? manager.fileExists(atPath: path), fileExists {
    //            guard let _ = try? manager.removeItem(atPath: path) else {
    //                XCTFail("Could not clear the state of test!!!")
    //                return
    //            }
    //        }
    //
    //    }
}
