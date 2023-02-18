//
//  DraftsPresenterTests.swift
//  bubble-jamTests
//
//  Created by Thiago Henrique on 18/02/23.
//

import XCTest
@testable import bubble_jam

final class DraftsPresenterTests: XCTestCase {
    var sut: DraftsPresenter!
    var useCase: UploadJamUseCase!
    var view: DraftViewDelegateSpy!
    
    override func setUp() {
        (sut, (useCase, view)) = makeSUT()
        XCTAssertNotNil(useCase.output)
        XCTAssertNotNil(sut.view)
    }
    func test_successfullyUploadJam_when_useCase_call_method_should_call_view() async {
        let url = Bundle(for: type(of: self)).url(forResource: "song", withExtension: "m4a")
        let inputDraft = Draft(audio: url!)
        await sut.uploadJam(draft: inputDraft)
        useCase.output!.forEach { $0.successfulyUploadJam(inputDraft) }
//        XCTAssertEqual([], )
    }

}

extension DraftsPresenterTests: Testing {
    typealias SutAndDoubles = (
        sut: DraftsPresenter, (
            useCase: UploadJamUseCase,
            viewDelegate: DraftViewDelegateSpy
        )
    )
    
    func makeSUT() -> SutAndDoubles {
        let database = DatabaseStub()
        let repository = DraftRepositoryStub(database: database)
        let useCase = UploadJamUseCase(repository: repository)
        let sut = DraftsPresenter(uploadJamUseCase: useCase)
        let viewDelegate = DraftViewDelegateSpy()
        
        sut.view = viewDelegate
        useCase.output = [sut]
        
        return (sut, (useCase, viewDelegate))
    }
}
