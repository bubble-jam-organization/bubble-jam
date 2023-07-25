//
//  BubbleGumViewControllerComposition.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 25/07/23.
//

import Foundation
import CloudKit

final class BubbleGumViewControllerAssembler: Assembler {
    static func make() -> BubblegumViewController {
        let datetimeService = DatetimeService()
        let database = CKContainer(identifier: Constants.containerIdentifier).publicCloudDatabase
        let mapper = ChallengeMapper(database: database)
        let repository = ChallengeRepository(database: database, mapper: mapper)
        let downloadUseCase = DownloadAudioRoutineUseCase(repository: repository)
        let presenter = BubblegumPresenter(downloadAudioUseCase: downloadUseCase)
        let viewController = BubblegumViewController(presenter: presenter)
        
        presenter.viewDelegate = viewController
        downloadUseCase.output = [presenter]
    
        return viewController
    }
}
