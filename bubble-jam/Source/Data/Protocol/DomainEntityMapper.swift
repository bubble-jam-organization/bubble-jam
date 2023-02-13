//
//  DomainEntityMapper.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 09/02/23.
//

import Foundation

protocol DomainEntityMapper {
    associatedtype DTO
    associatedtype DomainEntity
    func mapToDomain(_ dto: DTO) async throws -> DomainEntity
}
