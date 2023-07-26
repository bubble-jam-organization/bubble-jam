//
//  DraftRepositoryStub.swift
//  bubble-jamTests
//
//  Created by Thiago Henrique on 18/02/23.
//

import Foundation
@testable import BubbleJam

class DraftRepositoryDummy: DraftRepositoryProtocol {
    func downloadDraft(for challenge: Challenge) async throws -> Draft {
        return Draft(audio: URL(string: "song.m4a")!)
    }
    
    required init(database: Database, mapper: any DraftMapperProtocol) {
        self.database = database
        self.mapper = mapper
    }
    var mapper: any DraftMapperProtocol
    var database: Database
    
    func uploadDraft(_ draft: Draft) async throws { }
}
