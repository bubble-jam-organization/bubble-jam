//
//  ChallengeRecordType.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 14/02/23.
//

import Foundation

struct ChallengeRecordType: CloudKitQueryType {
    var recordType: String = "Challenge"
}

extension CloudKitQueryType where Self == ChallengeRecordType {
    static var challengeType: Self { .init() }
}
