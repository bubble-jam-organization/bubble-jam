//
//  ChallengeRepositoryProtocol.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 07/02/23.
//

import Foundation

protocol ChallengeRepositoryProtocol {
        
    var database: Database { get }
    var mapper: any ChallengeMapperProtocol { get }
    init(database: Database, mapper: any ChallengeMapperProtocol)
    func loadCurrentChallenge() async throws -> Challenge
}
