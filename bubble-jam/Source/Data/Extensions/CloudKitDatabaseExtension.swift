//
//  CloudKitDatabaseExtension.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 08/02/23.
//

import Foundation
import CloudKit

extension CKDatabase: Database { }

extension CKQuery {
    convenience init(_ queryType: CloudKitQueryType, predicate: NSPredicate) {
        self.init(recordType: queryType.recordType, predicate: predicate)
    }
}

extension CKRecord {
    convenience init(_ type: CloudKitQueryType, recordID: CKRecord.ID = CKRecord.ID()) {
        self.init(recordType: type.recordType, recordID: recordID)
    }
}
