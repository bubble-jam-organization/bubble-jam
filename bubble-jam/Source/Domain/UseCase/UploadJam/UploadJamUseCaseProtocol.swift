//
//  UploadJamUseCaseProtocol.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 18/02/23.
//

import Foundation

protocol UploadJamUseCaseProtocol: UseCase where
UseCaseInput == Draft,
UseCaseOutput ==  [UploadJamUseCaseOutput],
Gateway == DraftRepositoryProtocol {}
