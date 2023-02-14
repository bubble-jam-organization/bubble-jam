//
//  File.swift
//  bubble-jam
//
//  Created by Caio Soares on 13/02/23.
//

import Foundation
import CloudKit

class DraftRepository: DraftRepositoryProtocol {
    let database: Database
    
    required init(database: Database) {
        self.database = database
    }
    
    func uploadDraft(_ draft: Draft) async throws {
        let record = CKRecord(recordType: "Draft")
        let asset = CKAsset(fileURL: draft.audio)
        record.setValue(asset, forKey: "audio")
        do {
            _ = try await database.save(record)
        } catch {
            if let error = error as? CKError {
                throw DataSourceErrorHandler.handleError(error)
            }
            throw error
        }
    }
    
}
