//
//  DraftsPresenter.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 17/02/23.
//

import Foundation

class DraftsPresenter: DraftsPresenting {
    var uploadJamUseCase: any UploadJamUseCaseProtocol
    weak var view: DraftViewDelegate?
    
    init(uploadJamUseCase: UploadJamUseCase) {
        self.uploadJamUseCase = uploadJamUseCase
    }
    
    func uploadJam(draft: Draft) async {
        view?.startLoading()
        uploadJamUseCase.input = draft
        await uploadJamUseCase.execute()
        view?.hideLoading()
    }
}

extension DraftsPresenter: UploadJamUseCaseOutput {
    func successfulyUploadJam(_ jam: Draft) {
        view?.succesfullyUploadDraft(jam)
    }
    
    func failWhileUploadingJam(_ error: Error) {
        view?.failWhileUploadingDraft(error)
    }
}
