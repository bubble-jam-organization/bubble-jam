//
//  BubblegumViewDelegateSpy.swift
//  bubble-jamTests
//
//  Created by Thiago Henrique on 01/12/22.
//

import Foundation
@testable import bubble_jam

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
    func audioHasBeenLoaded() {
        receivedMessages.append(.audioHasBeenLoaded)
    }
    
    func audioIsPlaying(_ audio: bubble_jam.Audio) {
        receivedMessages.append(.isPlaying)
    }
    
    func startLoading() {
        receivedMessages.append(.startLoading)
    }
    
    func errorWhenLoadingAudio(title: String, description: String) {
        receivedMessages.append(.errorWhenLoadingAudio(title, description))
    }
}
