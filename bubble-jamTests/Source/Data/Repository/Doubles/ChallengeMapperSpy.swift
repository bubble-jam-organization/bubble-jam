//
//  ChallengeMapperSpy.swift
//  bubble-jamTests
//
//  Created by Thiago Henrique on 09/02/23.
//

import Foundation
@testable import bubble_jam
import CloudKit

class ChallengeMapperSpy: ChallengeMapperProtocol {
    private(set) var mapToDomainCalled = 0
    var database: Database
    var mapToDomainData: Challenge?
    
    required init(database: Database) { self.database = database }
    
    func mapToDomain(_ dto: CKRecord) async throws -> Challenge {
        mapToDomainCalled += 1
        assert(mapToDomainData != nil)
        return mapToDomainData!
    }

    func fetchChallengeAudio(reference: CKRecord.Reference) async throws -> AudioAndPropeties {
        return AudioAndPropeties(data: Data(), format: "m4a", notes: [], bpm: 0)
    }
}
