//
//  AudioAndPropetiesRecordType.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 17/02/23.
//

import Foundation

struct AudioAndPropetiesRecordType: CloudKitQueryType {
    var recordType: String = "AudioAndPropeties"
}

extension CloudKitQueryType where Self == AudioAndPropetiesRecordType {
    static var audioAndPropetiesType: Self { .init() }
}
