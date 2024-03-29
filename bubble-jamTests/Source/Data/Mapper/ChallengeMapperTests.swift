//
//  ChallengeMapperTests.swift
//  bubble-jamTests
//
//  Created by Thiago Henrique on 09/02/23.
//

import XCTest
import CloudKit
@testable import BubbleJam

final class ChallengeMapperTests: XCTestCase {
    func test_mapToDomain_should_map_data_correctly() async throws {
        let (sut, db) = makeSUT()
        let challengeData = generateChallengeData()
        let audioAndPropeties = generateAudioAndPropetiesData()
        db.fetchRecordPerIdData = audioAndPropeties.input
        let mappedData = try await sut.mapToDomain(challengeData.input)
        XCTAssertEqual(mappedData, challengeData.expected)
    }
    
    func test_mapToDomain_should_call_database_to_fetch_audio() async throws {
        let (sut, db) = makeSUT()
        let challengeData = generateChallengeData()
        let audioAndPropeties = generateAudioAndPropetiesData()
        db.fetchRecordPerIdData = audioAndPropeties.input
        _ = try await sut.mapToDomain(challengeData.input)
        XCTAssertEqual(db.fetchRecordPerIdCalled, 1)
    }
    
    func test_mapToDomain_should_call_database_many_times_needed_to_fetch_audio() async throws {
        let (sut, db) = makeSUT()
        let challengeData = generateChallengeData()
        let audioAndPropeties = generateAudioAndPropetiesData()
        db.fetchRecordPerIdData = audioAndPropeties.input
        _ = try await sut.mapToDomain(challengeData.input)
        _ = try await sut.mapToDomain(challengeData.input)
        _ = try await sut.mapToDomain(challengeData.input)
        XCTAssertEqual(db.fetchRecordPerIdCalled, 3)
    }
    
    func test_mapToDomain_should_throw_error_when_database_throw_error() async throws {
        let (sut, db) = makeSUT()
        let challengeData = generateChallengeData()
        db.fetchRecordsPerIdError = { throw CKError(CKError.Code(rawValue: 1)!) }
        do {
            _ = try await sut.mapToDomain(challengeData.input)
            XCTFail("Error should be throwed")
        } catch {}
    }
    
    func test_mapToDomain_should_throw_map_error_when_could_not_map() async throws {
        let (sut, _) = makeSUT()
        let inputRecord = CKRecord(.challengeType)
        inputRecord.setValuesForKeys([
            "title": 1,
            "description": "",
            "init": Date.now,
            "deadline": Date.distantFuture,
            "rules": [],
            "audio": CKRecord.Reference(
                record: CKRecord(.audioAndPropetiesType),
                action: .deleteSelf
            )
        ])
        do {
            _ = try await sut.mapToDomain(inputRecord)
            XCTFail("Error should be throwed")
        } catch {}
    }
    
    func test_mapToDomain_should_map_correctly() async throws {
        let (sut, db) = makeSUT()
        let challengeData = generateChallengeData()
        let audioData = generateAudioAndPropetiesData()
        db.fetchRecordPerIdData = audioData.input
        do {
            let challenge = try await sut.mapToDomain(challengeData.input)
            XCTAssertEqual(challenge, challengeData.expected)
        } catch {
            XCTFail("Test should not raise any error, but: \(error.localizedDescription)")
        }
    }
}

extension ChallengeMapperTests {
    func generateChallengeData() -> (input: CKRecord, expected: Challenge) {
        let title = "challenge"
        let description = "some description"
        let initDate = Date.now
        let deadline = Date.now
        let rules: [String] = []
        let audioData = generateAudioAndPropetiesData()
        let inputAudioRecord =  audioData.input
        
        func generateDTO() -> CKRecord {
            let inputRecord = CKRecord(.challengeType)
            inputRecord.setValuesForKeys([
                "title": title,
                "description": description,
                "init": initDate,
                "deadline": deadline,
                "rules": rules,
                "audio": CKRecord.Reference(record: inputAudioRecord, action: .deleteSelf)
            ])
            return inputRecord
        }
        
        func generateExpectedData() -> Challenge {
            return Challenge(
                title: title,
                description: description,
                banner: URL(string: "")!,
                rules: rules,
                initialDate: initDate,
                deadline: deadline,
                audio: audioData.expected
            )
        }
        
        return (generateDTO(), generateExpectedData())
    }
    
    func generateAudioAndPropetiesData() -> (input: CKRecord, expected: AudioAndPropeties) {
        let bundle = Bundle(for: type(of: self))
        let dataAsset = CKAsset(fileURL: bundle.url(forResource: "song", withExtension: "m4a")!)
        let bpm: UInt = 0
        let format = AudioFormat.m4a
        let notes = [Note.C, Note.A]
        
        func generateDTO() -> CKRecord {
            let inputRecord = CKRecord(.audioAndPropetiesType)
            inputRecord.setValuesForKeys([
                "data": dataAsset,
                "bpm": bpm,
                "format": format,
                "notes": notes
            ])
            return inputRecord
        }
        
        func generateExpectedData() -> AudioAndPropeties {
            return AudioAndPropeties(path: dataAsset.fileURL!, format: format, notes: notes, bpm: bpm)
        }
        
        return (generateDTO(), generateExpectedData())
    }
}

extension ChallengeMapperTests: Testing {
    typealias SutAndDoubles = (ChallengeMapper, DatabaseSpy)
    
    func makeSUT() -> SutAndDoubles {
        let database = DatabaseSpy()
        let sut = ChallengeMapper(database: database)
        return (sut, database)
    }
}
