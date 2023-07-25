//
//  Assembler.swift
//  bubble-jam
//
//  Created by Thiago Henrique on 25/07/23.
//

import Foundation

protocol Assembler {
    associatedtype ViewController
    static func make() -> ViewController
}
