//
//  ChallengeMapper.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 09/02/23.
//

import Foundation
import CloudKit

class ChallengeMapper: ChallengeMapperProtocol {
    var database: Database
    required init(database: Database) { self.database = database }
    
    func mapToDomain(_ dto: CKRecord) async throws -> Challenge {
        if let title = dto["title"] as? String,
           let description = dto["description"] as? String,
           let rules = dto["rules"] as? [String],
           let initialDate = dto["init"] as? Date,
           let deadline = dto["deadline"] as? Date,
           let audio = dto["audio"] as? CKRecord.Reference {
            return Challenge(
                title: title,
                description: description,
                rules: rules,
                initialDate: initialDate,
                deadline: deadline,
                audio: try await fetchChallengeAudio(reference: audio)
            )
        }
        throw MapperError.couldNotMapData
    }
    
    func fetchChallengeAudio(reference: CKRecord.Reference) async throws -> AudioAndPropeties {
        let audioRecord = try await database.record(for: reference.recordID)
        if let dataAsset = audioRecord["data"] as? CKAsset,
           let format = audioRecord["format"] as? String,
           let notes = audioRecord["notes"] as? [String],
           let bpm = audioRecord ["bpm"] as? UInt {
            do {
                let audioData = try Data(contentsOf: dataAsset.fileURL!)
                return AudioAndPropeties(data: audioData, format: format, notes: notes, bpm: bpm)
            } catch {
                throw MapperError.couldNotMapData
            }
        }
        throw MapperError.couldNotMapData
    }
}
