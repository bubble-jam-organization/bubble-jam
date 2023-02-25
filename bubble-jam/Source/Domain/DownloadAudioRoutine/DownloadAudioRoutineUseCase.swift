//
//  DownloadAudioRoutineUseCase.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 06/02/23.
//

import Foundation

class DownloadAudioRoutineUseCase {
    let repository: ChallengeRepositoryProtocol
    var output: [DownloadAudioRoutineOutput]?
    
    init(repository: ChallengeRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async {
        do {
            let challenge = try await repository.loadCurrentChallenge()
            output?.forEach { $0.successfullyLoadChallenge(challenge) }
        } catch {
            output?.forEach { $0.failWhileLoadingChallenge(error) }
        }
    }
}
