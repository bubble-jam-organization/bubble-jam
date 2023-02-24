//
//  DraftMapperProtocol.swift
//  bubble-jam
//
//  Created by Caio Soares on 24/02/23.
//

import Foundation
import CloudKit

protocol DraftMapperProtocol: DomainEntityMapper where DTO == CKRecord, DomainEntity == Draft {

}
