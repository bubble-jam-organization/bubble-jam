//
//  DownloadServiceSpy.swift
//  bubble-jamTests
//
//  Created by Thiago Henrique on 05/12/22.
//

import Foundation
@testable import bubble_jam

class DownloadServiceSpy {
    private(set) var receivedMessages: [Message] = [Message]()
    
    enum Message: Equatable {
        case downloadAudio(String, String)
        case loadSandboxAudio
        
        var description: String {
            switch self {
            case .downloadAudio(let audioName, let audioFormat):
                return "DownloadAudio called with data: \(audioName) and \(audioFormat)"
            case .loadSandboxAudio:
                return "LoadSandboxAudio called"
            }
        }
    }
}

extension DownloadServiceSpy: DownloadServicing {
    func loadTmpPathUrl() -> URL {
        //
        return URL(string: "")!
    }
    
    func downloadAudio(audioName: String, audioExtension: String) throws {
        receivedMessages.append(.downloadAudio(audioName, audioExtension))
    }
    
    func loadSandboxAudio() throws -> bubble_jam.Audio {
        receivedMessages.append(.loadSandboxAudio)
        return Audio(data: Data(), localAudioName: "", format: .unkwown, details: AudioDetails(notes: nil, description: nil, bpm: 0))
    }
}
