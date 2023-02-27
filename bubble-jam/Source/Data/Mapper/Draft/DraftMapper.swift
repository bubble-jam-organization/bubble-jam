//
//  DraftMapper.swift
//  bubble-jam
//
//  Created by Caio Soares on 24/02/23.
//

import Foundation
import CloudKit

class DraftMapper: DraftMapperProtocol {
    func mapToDomain(_ dto: CKRecord) async throws -> Draft {
        if let audio = dto["audio"] as? CKAsset {
            return Draft(audio: audio.fileURL!)
        }
        throw MapperError.couldNotMapData
    }
}
