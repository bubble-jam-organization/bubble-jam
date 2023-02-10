//
//  DatabaseSpy.swift
//  bubble-jamTests
//
//  Created by Thiago Henrique on 07/02/23.
//

import Foundation
import CloudKit
@testable import bubble_jam

class DatabaseSpy: Database {
    private(set) var fetchRecordsCalled = 0
    private(set) var fetchRecordPerIdCalled = 0
    
    // MARK: - Data
    var fetchRecordsData: [CKRecord] = []
    var fetchRecordsError: (() throws -> Void)?
    
    var fetchRecordPerIdData: CKRecord?
    var fetchRecordsPerIdError: (() throws -> Void)?

    // MARK: - Protocol Functions
    func records(matching query: CKQuery, inZoneWith zoneID: CKRecordZone.ID?) async throws -> [CKRecord] {
        fetchRecordsCalled += 1
        try fetchRecordsError?()
        return fetchRecordsData
    }
    
    func record(for recordID: CKRecord.ID) async throws -> CKRecord {
        fetchRecordPerIdCalled += 1
        try fetchRecordsPerIdError?()
        assert(fetchRecordPerIdData != nil)
        return fetchRecordPerIdData!
    }
}
