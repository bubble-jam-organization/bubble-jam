//
//  File.swift
//  bubble-jam
//
//  Created by Caio Soares on 13/02/23.
//

import Foundation
import CloudKit

class DraftRepository: DraftRepositoryProtocol {
    
    var database: Database
    var mapper: any DraftMapperProtocol
    
    required init(database: Database, mapper: any DraftMapperProtocol) {
        self.database = database
        self.mapper = mapper
    }
    
    func uploadDraft(_ draft: Draft) async throws {
        let record = CKRecord(.draftType)
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
    
    func downloadDraft() async throws -> Draft {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(.draftType, predicate: predicate)
        
        query.sortDescriptors = [NSSortDescriptor(key: "modificationDate", ascending: true)]
        
        do {
            let result = try await database.records(matching: query, inZoneWith: nil)
            if let mostRecentDraft = result.last {
                let domainEntity = try await mapper.mapToDomain(mostRecentDraft)
                return domainEntity
            }
            throw RepositoryError.draftNotFound
        } catch {
            if let error = error as? CKError {
                throw DataSourceErrorHandler.handleError(error)
            }
            throw error
        }
    }
    
    func downloadDraft(for challenge: Challenge) async throws -> Draft {
        let predicate = NSPredicate(format: "challenge==%@", CKRecord.ID(recordName: challenge.id.uuidString))
        let query = CKQuery(.draftType, predicate: predicate)
        
        do {
            let result = try await database.records(matching: query, inZoneWith: nil)
            print(result)
        } catch {
            print(error.localizedDescription)
        }
        return Draft(audio: URL(string: "")!)
    }
}
