//
//  DownloadJamUseCase.swift
//  bubble-jam
//
//  Created by Caio Soares on 24/02/23.
//

import Foundation

class DownloadJamUseCase {
    var output: [DownloadJamUseCaseOutput]?
    var repository: DraftRepositoryProtocol
    
    init(repository: DraftRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async {
        do {
            let draft = try await repository.downloadDraft()
            print("sending output")
            output?.forEach { $0.sucessfullyDownloadJams(draft) }
        } catch {
            print(error)
            output?.forEach { $0.failWhileDownloadingJam(error) }
        }
    }
}
