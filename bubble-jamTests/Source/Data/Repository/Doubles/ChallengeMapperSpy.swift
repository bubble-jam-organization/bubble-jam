//
//  ChallengeMapperSpy.swift
//  bubble-jamTests
//
//  Created by Thiago Henrique on 09/02/23.
//

import Foundation
@testable import BubbleJam
import CloudKit

class ChallengeMapperSpy: ChallengeMapperProtocol {
    private(set) var mapToDomainCalled = 0
    
    var database: Database
    var mapToDomainData: Challenge?
    var mapToDomainError: (() throws -> Void)?
    
    required init(database: Database) { self.database = database }
    
    // MARK: - Protocol functions
    
    func mapToDomain(_ dto: CKRecord) async throws -> Challenge {
        mapToDomainCalled += 1
        assert(mapToDomainData != nil)
        try mapToDomainError?()
        return mapToDomainData!
    }

    func fetchChallengeAudio(reference: CKRecord.Reference) async throws -> AudioAndPropeties {
        return AudioAndPropeties(
            path: URL(filePath: "song"),
            format: .m4a,
            notes: [],
            bpm: 0
        )
    }
}
