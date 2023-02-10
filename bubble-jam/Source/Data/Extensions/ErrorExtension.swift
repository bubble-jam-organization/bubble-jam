//
//  ErrorExtension.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 10/02/23.
//

import Foundation

extension LocalizedError where Self: CustomStringConvertible {
   var errorDescription: String? { return description }
}
