//
//  BubblegumViewDelegateSpy.swift
//  bubble-jamTests
//
//  Created by Thiago Henrique on 01/12/22.
//

import Foundation
@testable import BubbleJam

class BubblegumViewDelegateSpy {
    private(set) var receivedMessages: [Message] = [Message]()
    
    enum Message: Equatable {
        case audioHasBeenLoaded
        case errorWhenLoadingAudio(String, String)
        case startLoading
        case isPlaying
        
        var description: String {
            switch self {
                case .audioHasBeenLoaded:
                    return "audioHasBeenLoaded called"
                case .errorWhenLoadingAudio(let title, let description):
                    return "errorWhenLoadingAudio raised with: \(title) ; \(description)"
                case .startLoading:
                        return "startLoading called"
                case .isPlaying:
                    return "isPlaying called"
            }
        }
    }
    
}

extension BubblegumViewDelegateSpy: BubblegumViewDelegate {
    func audioIsPlaying(challenge: Challenge) {
        
    }
    
    func showChallenge(title: String, daysLeft: String) {
            
    }
    
    func errorWhenLoadingChallenge(title: String, description: String) {
        
    }
    
    func audioHasBeenLoaded() {
        receivedMessages.append(.audioHasBeenLoaded)
    }
    
    func audioIsPlaying() {
        receivedMessages.append(.isPlaying)
    }
    
    func startLoading() {
        receivedMessages.append(.startLoading)
    }
    
    func errorWhenLoadingAudio(title: String, description: String) {
        receivedMessages.append(.errorWhenLoadingAudio(title, description))
    }
}
