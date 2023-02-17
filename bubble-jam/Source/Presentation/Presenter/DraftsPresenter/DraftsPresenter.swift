//
//  DraftsPresenter.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 17/02/23.
//

import Foundation

class DraftsPresenter: DraftsPresenting {
    let uploadJamUseCase: UploadJamUseCase
    
    init(uploadJamUseCase: UploadJamUseCase) {
        self.uploadJamUseCase = uploadJamUseCase
    }
    
    func uploadJam(draft: Draft) {
        
    }
}
