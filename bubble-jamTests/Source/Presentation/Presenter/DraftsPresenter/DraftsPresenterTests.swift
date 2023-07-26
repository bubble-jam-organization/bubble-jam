//
//  DraftsPresenterTests.swift
//  bubble-jamTests
//
//  Created by Thiago Henrique on 18/02/23.
//

import XCTest
@testable import BubbleJam

final class DraftsPresenterTests: XCTestCase {
    var sut: DraftsPresenter!
    var useCase: UploadJamUseCaseDummy!
    var view: DraftViewDelegateSpy!
    
    override func setUp() {
        (sut, (useCase, view)) = makeSUT()
        XCTAssertNotNil(useCase.output)
        XCTAssertNotNil(sut.viewDelegate)
    }
    func test_uploadJam_when_useCase_succeded_should_call_view_correctly() async {
        let inputDraft = Draft(audio: generateMockedResourceUrl())
        await sut.uploadJam(draft: inputDraft)
        useCase.output!.forEach { $0.successfulyUploadJam(inputDraft) }
        XCTAssertEqual(
            view.receivedMessages,
            [.startLoading, .hideLoading, .succesfullyUploadDraft(inputDraft)]
        )
    }
    
    func test_uploadJam_when_useCase_fails_should_call_view_correctly() async {
        let inputDraft = Draft(audio: generateMockedResourceUrl())
        let inputError = NSError(domain: "ERROR", code: 0)
        await sut.uploadJam(draft: inputDraft)
        useCase.output!.forEach { $0.failWhileUploadingJam(inputError) }
        XCTAssertEqual(
            view.receivedMessages,
            [.startLoading, .hideLoading, .failWhileUploadingDraft]
        )
    }
}

extension DraftsPresenterTests {
    func generateMockedResourceUrl() -> URL {
        let url = Bundle(for: type(of: self)).url(forResource: "song", withExtension: "m4a")
        XCTAssertNotNil(url)
        return url!
    }
}

extension DraftsPresenterTests: Testing {
    typealias SutAndDoubles = (
        sut: DraftsPresenter, (
            useCase: UploadJamUseCaseDummy,
            viewDelegate: DraftViewDelegateSpy
        )
    )
    
    func makeSUT() -> SutAndDoubles {
        let database = DatabaseStub()
        let mapperDummy = DraftMapperDummy()
        let repository = DraftRepositoryDummy(database: database, mapper: mapperDummy)
        let useCase = UploadJamUseCaseDummy(repository: repository)
        let downloadUseCase = DownloadJamUseCaseDummy(repository: repository)
        let sut = DraftsPresenter(uploadJamUseCase: useCase, downloadChallengeJamUseCase: downloadUseCase)
        let viewDelegate = DraftViewDelegateSpy()
        
        sut.viewDelegate = viewDelegate
        useCase.output = [sut]
        
        return (sut, (useCase, viewDelegate))
    }
    
    final class DownloadJamUseCaseDummy: DownloadJamUseCaseProtocol {
        var repository: BubbleJam.DraftRepositoryProtocol
        
        var output: [DownloadJamUseCaseOutput]?
        
        var input: BubbleJam.Challenge?
        
        init(repository: BubbleJam.DraftRepositoryProtocol) {
            self.repository = repository
        }
        
        func execute() async { }
    }
}
