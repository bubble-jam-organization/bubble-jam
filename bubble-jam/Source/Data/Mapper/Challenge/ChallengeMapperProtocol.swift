//
//  ChallengeMapperProtocol.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 09/02/23.
//

import Foundation
import CloudKit

protocol ChallengeMapperProtocol: DomainEntityMapper where DTO == CKRecord, DomainEntity == Challenge {
    var database: Database { get }
    init(database: Database)
    func fetchChallengeAudio(reference: CKRecord.Reference) async throws -> AudioAndPropeties
}
