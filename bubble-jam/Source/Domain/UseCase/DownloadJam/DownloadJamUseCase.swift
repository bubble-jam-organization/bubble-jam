//
//  DownloadJamUseCase.swift
//  bubble-jam
//
//  Created by Caio Soares on 24/02/23.
//

import Foundation

class DownloadJamUseCase: DownloadJamUseCaseProtocol {
    var input: Any? = nil
    var output: [DownloadJamUseCaseOutput]?
    var repository: DraftRepositoryProtocol
    
    required init(repository: DraftRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async {
        do {
            let draft = try await repository.downloadDraft()
            output?.forEach{ $0.sucessfullyDownloadJams(draft) }
        } catch {
            output?.forEach{ $0.failWhileDownloadingJam(error) }
        }
    }
}
