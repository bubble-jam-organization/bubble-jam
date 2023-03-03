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
        let group = DispatchGroup()

        group.enter()
        var currentDate = await dateService.getCurrentDate()
        group.leave()
        
        group.enter()
        do {
            let challenge = try await repository.loadCurrentChallenge()
            group.leave()
            group.notify(queue: .global()) { [weak self] in
                if let currentDate = currentDate {
                    self?.output?.forEach { $0.successfullyLoadChallenge(challenge, date: currentDate) }
                } else {
                    self?.output?.forEach { $0.successfullyLoadChallenge(challenge, date: Date.now) }
                }
                
            }

        } catch {
            output?.forEach { $0.failWhileLoadingChallenge(error) }
        }
    
        
    }
}
