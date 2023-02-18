//
//  UploadJamUseCase.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 17/02/23.
//

import Foundation

class UploadJamUseCase: UseCase {
    var input: Draft?
    var output: [UploadJamUseCaseOutput]?
    var repository: DraftRepositoryProtocol
    
    required init(repository: DraftRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async {
        if let input = input {
            do {
                try await repository.uploadDraft(input)
                output?.forEach { $0.successfulyUploadJam(input) }
            } catch {
                output?.forEach { $0.failWhileUploadingJam(error) }
            }
        }
    }
}
