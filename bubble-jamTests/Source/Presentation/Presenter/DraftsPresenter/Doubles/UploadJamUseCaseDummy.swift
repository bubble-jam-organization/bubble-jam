//
//  UploadJamUseCaseSpy.swift
//  bubble-jamTests
//
//  Created by Thiago Henrique on 18/02/23.
//

import Foundation
@testable import BubbleJam

class UploadJamUseCaseDummy: UploadJamUseCaseProtocol {
    var repository: DraftRepositoryProtocol
    var output: [UploadJamUseCaseOutput]?
    var input: Draft?
    
    required init(repository: DraftRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async {}
}
