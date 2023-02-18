//
//  DraftsViewDelegateSpy.swift
//  bubble-jamTests
//
//  Created by Thiago Henrique on 18/02/23.
//

import Foundation
@testable import bubble_jam

class DraftViewDelegateSpy: DraftViewDelegate {
    func startLoading() {}
    
    func hideLoading() {}
    
    func succesfullyUploadDraft(_ jam: bubble_jam.Draft) {}
    
    func failWhileUploadingDraft(_ error: Error) {}
}
