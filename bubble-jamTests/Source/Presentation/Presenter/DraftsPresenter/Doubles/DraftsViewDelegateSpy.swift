//
//  DraftsViewDelegateSpy.swift
//  bubble-jamTests
//
//  Created by Thiago Henrique on 18/02/23.
//

import Foundation
@testable import BubbleJam

class DraftViewDelegateSpy: DraftViewDelegate {
    func draftHasBeenDownloaded(_ jam: BubbleJam.Draft) {
        
    }
    
    func failWhileDownloadingDraft(_ error: Error) {
        
    }
    
    private(set) var receivedMessages: [DraftViewMessage] = [DraftViewMessage]()
    
    enum DraftViewMessage: Equatable, CustomStringConvertible {
        case startLoading
        case hideLoading
        case succesfullyUploadDraft(Draft)
        case failWhileUploadingDraft
        
        var description: String {
            switch self {
                case .startLoading:
                    return "startLoading Called"
                case .hideLoading:
                    return "hideLoading Called"
                case .succesfullyUploadDraft(let draft):
                    return "succesfullyUploadDraft with data: \(draft)"
                case .failWhileUploadingDraft:
                    return "failWhileUploadingDraft called"
            }
        }
    }
}

extension DraftViewDelegateSpy {
    func startLoading() {
        receivedMessages.append(.startLoading)
    }
    
    func hideLoading() {
        receivedMessages.append(.hideLoading)
    }
    
    func succesfullyUploadDraft(_ jam: Draft) {
        receivedMessages.append(.succesfullyUploadDraft(jam))
    }
    
    func failWhileUploadingDraft(_ error: Error) {
        receivedMessages.append(.failWhileUploadingDraft)
    }
}
