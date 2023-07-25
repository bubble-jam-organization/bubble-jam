//
//  DraftViewControllerAssembler.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 25/07/23.
//

import Foundation
import CloudKit

final class DraftViewControllerAssembler: Assembler {
    static func make() -> DraftsViewController {
        let database = CKContainer(identifier: Constants.containerIdentifier).privateCloudDatabase
        let mapper = DraftMapper()
        let repository = DraftRepository(database: database, mapper: mapper)
        let uploadUseCase = UploadJamUseCase(repository: repository)
        let downloadChallengeJamUseCase = DownloadChallengeJamsUseCase(repository: repository)
        let presenter = DraftsPresenter(
            uploadJamUseCase: uploadUseCase,
            downloadChallengeJamUseCase: downloadChallengeJamUseCase
        )
        let view = DraftsViewController(presenter: presenter)
        
        uploadUseCase.output = [presenter]
        downloadChallengeJamUseCase.output = [presenter]
        presenter.viewDelegate = view
        
        return view
    }
}
