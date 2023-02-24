//
//  DraftsPresenter.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 17/02/23.
//

import Foundation

class DraftsPresenter: DraftsPresenting {
    
    private var uploadJamUseCase: any UploadJamUseCaseProtocol
    private var downloadJamUseCase: any DownloadJamUseCaseProtocol
    weak var view: DraftViewDelegate?
    
    init(uploadJamUseCase: any UploadJamUseCaseProtocol, downloadJamUseCase: any DownloadJamUseCaseProtocol) {
        self.uploadJamUseCase = uploadJamUseCase
        self.downloadJamUseCase = downloadJamUseCase
    }
    
    func uploadJam(draft: Draft) async {
        view?.startLoading()
        uploadJamUseCase.input = draft
        await uploadJamUseCase.execute()
        view?.hideLoading()
    }
    
    func downloadJam() async {
        view?.startLoading()
        await downloadJamUseCase.execute()
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

extension DraftsPresenter: DownloadJamUseCaseOutput {
    func sucessfullyDownloadJams(_ jam: Draft) {
        print("ayo")
        view?.draftHasBeenDownloaded(jam)
    }
    
    func failWhileDownloadingJam(_ error: Error) {
        print("ayo but differente")
        view?.failWhileDownloadingDraft(error)
    }
}
