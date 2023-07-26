//
//  DatabaseDummy.swift
//  bubble-jamTests
//
//  Created by Thiago Henrique on 18/02/23.
//

import Foundation
import CloudKit
@testable import BubbleJam

class DatabaseStub: Database {
    func records(matching query: CKQuery, inZoneWith zoneID: CKRecordZone.ID?) async throws -> [CKRecord] {
        return []
    }
    
    func record(for recordID: CKRecord.ID) async throws -> CKRecord {
        return CKRecord(recordType: "")
    }
    
    func save(_ record: CKRecord) async throws -> CKRecord {
        return CKRecord(recordType: "")
    }
}
