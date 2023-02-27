//
//  DraftRepositoryProtocol.swift
//  bubble-jam
//
//  Created by Caio Soares on 13/02/23.
//

import Foundation

protocol DraftRepositoryProtocol {
    var database: Database { get }
    func uploadDraft(_ draft: Draft) async throws
    func downloadDraft() async throws -> Draft
    init(database: Database, mapper: any DraftMapperProtocol)
}
