//
//  ChallengeRepository.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 07/02/23.
//

import Foundation
import CloudKit

class ChallengeRepository: ChallengeRepositoryProtocol {
    let database: Database
    let mapper: any ChallengeMapperProtocol
    
    required init(database: Database, mapper: any ChallengeMapperProtocol) {
        self.database = database
        self.mapper = mapper
    }
    
    func loadCurrentChallenge() async throws -> Challenge {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(.challengeType, predicate: predicate)
        
        do {
            let result = try await database.records(matching: query, inZoneWith: nil)
            if let mostRecentChallenge = result.first {
                let domainEntity = try await mapper.mapToDomain(mostRecentChallenge)
                return domainEntity
            }
            throw RepositoryError.challengeNotFound
        } catch {
            if let error = error as? CKError {
                throw DataSourceErrorHandler.handleError(error)
            }
            throw error
        }
    }
}
