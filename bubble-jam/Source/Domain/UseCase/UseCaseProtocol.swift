//
//  UseCaseProtocol.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 18/02/23.
//

import Foundation

protocol UseCase {
    associatedtype Gateway
    associatedtype UseCaseOutput
    associatedtype UseCaseInput
    var repository: Gateway { get set }
    var output: UseCaseOutput? { get set }
    var input: UseCaseInput? { get set }
    init(repository: Gateway)
    func execute() async
}
