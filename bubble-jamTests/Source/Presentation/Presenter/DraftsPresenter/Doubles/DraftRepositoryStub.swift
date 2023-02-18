//
//  DraftRepositoryStub.swift
//  bubble-jamTests
//
//  Created by Thiago Henrique on 18/02/23.
//

import Foundation
@testable import bubble_jam

class DraftRepositoryStub: DraftRepositoryProtocol {
    var database: Database
    
    func uploadDraft(_ draft: Draft) async throws { }
    
    required init(database: Database) {
        self.database = database
    }
}
