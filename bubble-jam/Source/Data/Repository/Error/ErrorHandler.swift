//
//  ErrorHandler.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 10/02/23.
//

import Foundation
import CloudKit

struct DataSourceError: LocalizedError, CustomStringConvertible {
    var dataSourceErrorDescription: String
    var recoverySuggestion: String?
    
    var description: String {  return
        "\(dataSourceErrorDescription) \(recoverySuggestion ?? "")"
    }
}

class DataSourceErrorHandler {
    static func handleError(_ error: Error) -> Error {
        if let ckError = error as? CKError {
            switch ckError.code {
            case .networkUnavailable:
                return DataSourceError(
                    dataSourceErrorDescription: "Internet não disponível!",
                    recoverySuggestion: "Verifique sua conexão e tente novamente"
                )
            case .networkFailure:
                return DataSourceError(
                    dataSourceErrorDescription: "Não foi possível concluir a operação devido uma falha na comunicação da internet!",
                    recoverySuggestion: "Verifique sua conexão e tente novamente"
                )
            case .serviceUnavailable:
                return DataSourceError(
                    dataSourceErrorDescription: "Serviço indisponível!",
                    recoverySuggestion: "Tente novamente mais tarde"
                )
            case .requestRateLimited:
                return DataSourceError(
                    dataSourceErrorDescription: "O limite máximo de requisições foi atingido!",
                    recoverySuggestion: "Tente novamente mais tarde"
                )
            case .notAuthenticated:
                return DataSourceError(
                    dataSourceErrorDescription: "Usuário não autenticado!",
                    recoverySuggestion: "Verifique sua conta e tente novamente"
                )
            case .accountTemporarilyUnavailable:
                return DataSourceError(
                    dataSourceErrorDescription: "Conta iCloud indisponível!",
                    recoverySuggestion: "Verifique sua conta iCloud e tente novamente"
                )
            case .permissionFailure:
                return DataSourceError(
                    dataSourceErrorDescription: "Usuário sem permissão para concluir essa operação!",
                    recoverySuggestion: "Verifique sua conta e tente novamente!"
                )
            case .serverRecordChanged:
                return DataSourceError(
                    dataSourceErrorDescription: "Não foi possível realizar a operação devido há um conflito de informações entre o aplicativo e o servidor!",
                    recoverySuggestion: "Atualize o aplicativo e tente novamente!"
                )
            case .serverRejectedRequest:
                return DataSourceError(
                    dataSourceErrorDescription: "Essa solicitação foi recusada pelo servidor",
                    recoverySuggestion: "Tente novamente mais tarde!"
                )
            case .incompatibleVersion:
                return DataSourceError(
                    dataSourceErrorDescription: "Ocorreu um conflito de versões!",
                    recoverySuggestion: "Atualize o aplicativo e tente novamente!"
                )
            case .assetFileNotFound:
                return DataSourceError(
                    dataSourceErrorDescription: "Não foi possível encontrar o arquivo solicitado no servidor!"
                )
            case .assetNotAvailable:
                return DataSourceError(
                    dataSourceErrorDescription: "O sistema não pôde acessar o arquivo solicitado!"
                )
            case .assetFileModified:
                return DataSourceError(
                    dataSourceErrorDescription: "O arquivo foi alterado enquanto estava sendo salvo",
                    recoverySuggestion: "Se as modificações não foram realizadas, tente novamente!"
                )
            case .unknownItem:
                return DataSourceError(dataSourceErrorDescription: "O registro solicitado não existe!")
            case .changeTokenExpired:
                return DataSourceError(
                    dataSourceErrorDescription: "Sua sessão se esgotou!",
                    recoverySuggestion: "Realize o login novamente para utilizar o aplicativo!"
                )
            case .zoneBusy:
                return DataSourceError(
                    dataSourceErrorDescription: "O servidor apresentou problemas para lidar com a operação",
                    recoverySuggestion: "Tente novamente em alguns segundos!"
                )
            case .quotaExceeded:
                return DataSourceError(
                    dataSourceErrorDescription: "O usuário não possui espaço suficiente!",
                    recoverySuggestion: "Libere espaço na sua conta iCloud e tente novamente"
                )
            case .limitExceeded:
                return DataSourceError(
                    dataSourceErrorDescription: "A solicitação realizada é muito grande!",
                    recoverySuggestion: "Diminua a quantiade de itens presentes na solicitação e tente novamente!"
                )
            case .tooManyParticipants:
                return DataSourceError(
                    dataSourceErrorDescription: "Não foi possível compartilhar os dados pois foi excedido o número de compartilhamentos autorizados"
                )
            case .managedAccountRestricted:
                return DataSourceError(
                    dataSourceErrorDescription: "A solicitação foi negada devido a uma restrição a conta!"
                )
            case .serverResponseLost:
                return DataSourceError(
                    dataSourceErrorDescription: "Resposta do servidor perdida",
                    recoverySuggestion: "Aguarde alguns minutos e tente novamente!"
                )
            case .alreadyShared:
                return DataSourceError(
                    dataSourceErrorDescription: "A operação não pôde ser concluida pois o registro já foi compartilhado!"
                )
            case .participantMayNeedVerification:
                return DataSourceError(
                    dataSourceErrorDescription: "O usuário não está autorizado a verificar o item compartilhado!"
                )
            case .internalError,
                    .partialFailure,
                    .missingEntitlement,
                    .badContainer,
                    .invalidArguments,
                    .resultsTruncated,
                    .constraintViolation,
                    .operationCancelled,
                    .batchRequestFailed,
                    .badDatabase,
                    .zoneNotFound,
                    .userDeletedZone,
                    .referenceViolation:
                return DataSourceError(
                    dataSourceErrorDescription: "Ocorreu um problema interno!",
                    recoverySuggestion: "Verifique se existe alguma atualização do aplicativo disponível. Se o error persistir, busque suporte em nossos canais de comunicação"
                )
            @unknown default:
                return DataSourceError(
                    dataSourceErrorDescription: "Erro não mapeado!",
                    recoverySuggestion: "Verifique se existe alguma atualização do aplicativo disponível e tente novamente."
                )
            }
        }
        return error
    }
}
