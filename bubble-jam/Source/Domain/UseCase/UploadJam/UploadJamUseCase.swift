//
//  UploadJamUseCase.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 17/02/23.
//

import Foundation

class UploadJamUseCase {
    var input: Draft
    var output: UploadJamUseCaseOutput?
    var repository: DraftRepositoryProtocol
    
    init(input: Draft, repository: DraftRepositoryProtocol) {
        self.repository = repository
        self.input = input
    }
    
    func execute() async {
        do {
            try await repository.uploadDraft(input)
            output?.successfulyUploadJam()
        } catch {
            output?.failWhileUploadingJam(error)
        }
    }
}
