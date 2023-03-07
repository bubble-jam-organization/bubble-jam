//
//  DownloadChallengeJamsUseCase.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 06/03/23.
//

import Foundation

class DownloadChallengeJamsUseCase: DownloadJamUseCaseProtocol {
    var repository: DraftRepositoryProtocol
    var input: Challenge?
    var output: [DownloadJamUseCaseOutput]?
    
    required init(repository: DraftRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async {
        if let input = input {
            do {
                let result = try await repository.downloadDraft(for: input)
                output?.forEach { $0.sucessfullyDownloadJams(result) }
            } catch {
                output?.forEach { $0.failWhileDownloadingJam(error) }
            }
        }
    }
}
