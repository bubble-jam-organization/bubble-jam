//
//  DraftRecordType.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 14/02/23.
//

import Foundation

struct DraftRecordType: CloudKitQueryType {
    var recordType: String = "Draft"
}

extension CloudKitQueryType where Self == DraftRecordType {
    static var draftType: Self { .init() } 
}
