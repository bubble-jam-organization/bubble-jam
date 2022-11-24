//
//  Testing.swift
//  bubble-jamTests
//
//  Created by Otávio Albuquerque on 24/11/22.
//

import Foundation

protocol Testing {
    associatedtype SutAndDoubles
    func makeSUT() -> SutAndDoubles
}
