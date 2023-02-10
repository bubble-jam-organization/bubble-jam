//
//  ChallengeRepositoryTests.swift
//  bubble-jamTests
//
//  Created by Thiago Henrique on 07/02/23.
//

import XCTest
@testable import bubble_jam
import CloudKit

final class ChallengeRepositoryTests: XCTestCase {
    var sut: ChallengeRepository!
    var database: DatabaseSpy!
    var mapper: ChallengeMapperSpy!
    
    override func setUp() {
        (sut, database, mapper) = makeSUT()
        database.fetchRecordsData = [generateDatabaseChallengeResponse()]
        mapper.mapToDomainData = generateExpectedChallenge()
    }
    
    func test_loadCurrentChallenge_should_call_database() async throws {
        _ = try await sut.loadCurrentChallenge()
        XCTAssertEqual(database.fetchRecordsCalled, 1)
    }
    
    func test_loadCurrentChallenge_should_call_database_many_times_needed() async throws {
        _ = try await sut.loadCurrentChallenge()
        _ = try await sut.loadCurrentChallenge()
        XCTAssertEqual(database.fetchRecordsCalled, 2)
    }
    
    func test_loadCurrentChallenge_should_call_mapper() async throws {
        _ = try await sut.loadCurrentChallenge()
        XCTAssertEqual(mapper.mapToDomainCalled, 1)
    }
    
    func test_loadCurrentChallenge_should_call_mapper_many_times_needed() async throws {
        _ = try await sut.loadCurrentChallenge()
        _ = try await sut.loadCurrentChallenge()
        _ = try await sut.loadCurrentChallenge()
        XCTAssertEqual(mapper.mapToDomainCalled, 3)
    }
    
    func test_loadCurrentChallenge_when_database_throw_error_should_handle_error_correctly() async throws {
        database.fetchRecordsError = { throw CKError(CKError.Code(rawValue: 4)!) }
        do {
            _ = try await sut.loadCurrentChallenge()
        } catch {
            XCTAssertEqual(
                error.localizedDescription,
                "Não foi possível concluir a operação devido uma falha na comunicação da internet! Verifique sua conexão e tente novamente"
            )
        }
    }
    
    func test_loadCurrentChallenge_when_challengeNotFound_should_handle_correcly() async throws {
        database.fetchRecordsData = []
        do {
            _ = try await sut.loadCurrentChallenge()
        } catch {
            XCTAssertNotNil(error as? RepositoryError)
        }
    }
    
    func test_loadCurrentChallenge_when_challengeNotFound_should_raise_correct_description() async throws {
        database.fetchRecordsData = []
        do {
            _ = try await sut.loadCurrentChallenge()
        } catch {
            XCTAssertEqual(error.localizedDescription, "Não foi possível encontrar um challenge!")
        }
    }
    
    func test_loadCurrentChallenge_when_mapper_fails_error_should_be_MapperError() async throws {
        mapper.mapToDomainError = { throw MapperError.couldNotMapData }
        do {
            _ = try await sut.loadCurrentChallenge()
        } catch {
            XCTAssertNotNil(error as? MapperError)
        }
    }
    
    func test_loadCurrentChallenge_when_mapper_fails_should_raise_correct_description() async throws {
        mapper.mapToDomainError = { throw MapperError.couldNotMapData }
        do {
            _ = try await sut.loadCurrentChallenge()
        } catch {
            XCTAssertEqual(
                error.localizedDescription,
                "Ocorreu um erro no mapeamento dos dados! Verifique se existe alguma atualização do aplicativo e tente novamente!"
            )
        }
    }
}

extension ChallengeRepositoryTests {
    func generateDatabaseChallengeResponse() -> CKRecord {
        return CKRecord(recordType: "Challenge")
    }
    
    func generateExpectedChallenge() -> Challenge {
        return Challenge(
            title: "",
            description: "",
            rules: [],
            initialDate: Date.now,
            deadline: Date.distantFuture,
            audio: AudioAndPropeties(
                data: Data(),
                format: "",
                notes: [],
                bpm: 0
            )
        )
    }
}

extension ChallengeRepositoryTests: Testing {
    typealias SutAndDoubles = (ChallengeRepository, DatabaseSpy, ChallengeMapperSpy)
    
    func makeSUT() -> SutAndDoubles {
        let database = DatabaseSpy()
        let mapper = ChallengeMapperSpy(database: database)
        let sut = ChallengeRepository(database: database, mapper: mapper)
        return (sut, database, mapper)
    }
}
