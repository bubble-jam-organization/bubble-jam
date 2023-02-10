//
//  DatabaseProtocol.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 07/02/23.
//

import Foundation
import CloudKit

protocol Database {
    func records(matching query: CKQuery, inZoneWith zoneID: CKRecordZone.ID?) async throws -> [CKRecord]
    func record(for recordID: CKRecord.ID) async throws -> CKRecord
}
