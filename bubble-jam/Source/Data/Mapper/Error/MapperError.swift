//
//  MapperError.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 09/02/23.
//

import Foundation

enum MapperError: LocalizedError {
    case couldNotMapData
    
    var errorDescription: String? {
        switch self {
            case .couldNotMapData:
                return "Ocorreu um erro no mapeamento dos dados! Verifique se existe alguma atualização do aplicativo e tente novamente!"
        }
    }
}
