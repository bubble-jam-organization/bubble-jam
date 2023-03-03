//
//  DatetimeServicing.swift
//  bubble-jam
//
//  Created by Otávio Albuquerque on 06/12/22.
//

import Foundation
protocol DateServicing {
    var limitDate: DateComponents { get }
    func getCurrentDate() async -> Date?
}
