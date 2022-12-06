//
//  AudioServiceError.swift
//  bubble-jam
//
//  Created by Otávio Albuquerque on 24/11/22.
//

import Foundation

enum AudioServiceError: Error, Equatable, LocalizedError {
    case nonExistingAudio
    case unkwownError
    
    var errorDescription: String? {
        switch self {
            case .nonExistingAudio:
                return "Não foi possível encontrar o áudio!"
            case .unkwownError:
                return "Error desconhecido, reinicie o aplicativo e tente novamente!"
        }
    }
}
