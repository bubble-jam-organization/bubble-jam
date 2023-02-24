//
//  DownloadJamUseCaseProtocol.swift
//  bubble-jam
//
//  Created by Caio Soares on 24/02/23.
//

import Foundation

protocol DownloadJamUseCaseProtocol: UseCase where
UseCaseOutput == [DownloadJamUseCaseOutput],
Gateway == DraftRepositoryProtocol {}
