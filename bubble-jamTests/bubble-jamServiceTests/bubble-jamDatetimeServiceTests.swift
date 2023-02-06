//
//  bubble-jamDatetimeServiceTests.swift
//  bubble-jamTests
//
//  Created by Otávio Albuquerque on 06/12/22.
//

import XCTest
@testable import bubble_jam

final class bubble_jamDatetimeServiceTests: XCTestCase {

    func test_datetime_shouldGetCurrentDate() {
        let (sut, _) = makeSUT()
        XCTAssertEqual(Date.now, sut.getCurrentDate())
        
    }

}

extension bubble_jamDatetimeServiceTests: Testing {
    func makeSUT() -> (bubble_jam.DatetimeService, Calendar) {
        let calendar = Calendar(identifier: .gregorian)
        let sut = DatetimeService(calendar: calendar)
        return (sut, calendar)
    }
    
    typealias SutAndDoubles = (DatetimeService, Calendar)
    
}
