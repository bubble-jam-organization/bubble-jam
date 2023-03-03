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
        let dateService = DatetimeService()

        do {
            async let challenge: Challenge = try await repository.loadCurrentChallenge()
            async let currentDate: Date? = await dateService.getCurrentDate()
            let (fetchedChallenge, fetchedDate) = await (try challenge, currentDate)
            if let fetchedDate = fetchedDate {
                self.output?.forEach { $0.successfullyLoadChallenge(fetchedChallenge, date: fetchedDate) }
            } else {
                self.output?.forEach { $0.successfullyLoadChallenge(fetchedChallenge, date: Date.now) }
            }

        } catch {
            output?.forEach { $0.failWhileLoadingChallenge(error) }
        }
    
    }
}
