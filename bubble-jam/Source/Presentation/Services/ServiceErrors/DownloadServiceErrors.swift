//
//  DownloadServiceErrors.swift
//  bubble-jam
//
//  Created by Otávio Albuquerque on 25/11/22.
//

import Foundation

enum DownloadServiceError: Error, Equatable {
    case fileNotExists
    case fileAlreadyExists
    case unableToDownloadItem(String)
}
