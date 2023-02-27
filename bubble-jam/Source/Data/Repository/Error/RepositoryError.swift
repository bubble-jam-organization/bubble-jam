//
//  RepositoryError.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 10/02/23.
//

import Foundation

enum RepositoryError: Error, Equatable, LocalizedError {
    case challengeNotFound
    case draftNotFound
    
    var errorDescription: String? {
        switch self {
            case .challengeNotFound:
                return "Não foi possível encontrar um challenge!"
            case .draftNotFound:
                return "Não foi possível encontrar um draft previamente enviado! Você já enviou um?"
        }
    }
}
