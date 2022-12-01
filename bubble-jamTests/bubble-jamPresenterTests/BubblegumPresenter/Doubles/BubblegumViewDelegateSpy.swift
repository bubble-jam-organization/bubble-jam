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
        case audioHasBeenLoaded(Audio)
        case errorWhenLoadingAudio(String, String)
        
        var description: String {
            switch self {
                case .audioHasBeenLoaded(let audio):
                    return "audioHasBeenLoaded with data: \(String(describing: audio.localAudioName))"
                case .errorWhenLoadingAudio(let title, let description):
                    return "errorWhenLoadingAudio raised with: \(title) ; \(description)"
            }
        }
    }
    
}

extension BubblegumViewDelegateSpy: BubblegumViewDelegate {
    func errorWhenLoadingAudio(title: String, description: String) {
        receivedMessages.append(.errorWhenLoadingAudio(title, description))
    }
    
    func audioHasBeenLoaded(_ audio: bubble_jam.Audio) {
        receivedMessages.append(.audioHasBeenLoaded(audio))
    }
}
