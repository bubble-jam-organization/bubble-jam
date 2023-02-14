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
    convenience init(queryType: CloudKitQueryType, predicate: NSPredicate) {
        self.init(recordType: queryType.recordType, predicate: predicate)
    }
}
