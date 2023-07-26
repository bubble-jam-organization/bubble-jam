//
//  DraftRepositoryTests.swift
//  bubble-jamTests
//
//  Created by Caio Soares on 14/02/23.
//

import XCTest
import CloudKit
@testable import BubbleJam

final class DraftRepositoryTests: XCTestCase {
    
    func test_uploadDraft_when_valid_should_sucessfullyCallDatabaseToSave() async throws {
        let (sut, database) = makeSUT()
        
        database.saveRecordData = CKRecord(.draftType)
        let bundle = Bundle(for: type(of: self))
        let fileUrl = bundle.url(forResource: "song", withExtension: "m4a")
        let draft = Draft(audio: fileUrl!)
        
        try await sut.uploadDraft(draft)
        
        XCTAssertEqual(database.saveRecordCalled, 1)
    }
    
    func test_uploadDraft_when_valid_should_beCalledAsManyTimesAsNeeded() async throws {
        let (sut, database) = makeSUT()
        database.saveRecordData = CKRecord(.draftType)
        let bundle = Bundle(for: type(of: self))
        let fileUrl = bundle.url(forResource: "song", withExtension: "m4a")
        let draft = Draft(audio: fileUrl!)
        let randomNumberOfCalls = Int.random(in: 1..<10)
        
        for _ in 1...randomNumberOfCalls {
            try await sut.uploadDraft(draft)
        }
        
        XCTAssertEqual(database.saveRecordCalled, randomNumberOfCalls)
    }
    
    func test_uploadDraft_when_saveRecordDataInvalid_should_throwError() async throws {
        let (sut, database) = makeSUT()
        database.saveRecordError = { throw CKError(CKError.Code(rawValue: 4)!)}
        let bundle = Bundle(for: type(of: self))
        let fileUrl = bundle.url(forResource: "song", withExtension: "m4a")
        let draft = Draft(audio: fileUrl!)
        
        do {
            try await sut.uploadDraft(draft)
        } catch {
            XCTAssertEqual(
                error.localizedDescription,
                "Não foi possível concluir a operação devido uma falha na comunicação da internet! Verifique sua conexão e tente novamente"
            )
        }
    }
    
}

extension DraftRepositoryTests: Testing {
    typealias SutAndDoubles = (DraftRepository, DatabaseSpy)
    func makeSUT() -> SutAndDoubles {
        let databaseSpy = DatabaseSpy()
        let mapperDummy = DraftMapperDummy()
        let sut = DraftRepository(database: databaseSpy, mapper: mapperDummy)
        return (sut, databaseSpy)
    }
}

final class DraftMapperDummy: DraftMapperProtocol {
    func mapToDomain(_ dto: CKRecord) async throws -> Draft {
        return Draft(audio: URL(string: "song.m4a")!)
    }
}
