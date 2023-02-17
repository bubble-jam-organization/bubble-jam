//
//  UploadJamUseCaseOutput.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 17/02/23.
//

import Foundation

protocol UploadJamUseCaseOutput {
    func successfulyUploadJam()
    func failWhileUploadingJam(_ error: Error)
}
