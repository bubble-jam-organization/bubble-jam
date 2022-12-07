//
//  DatetimeService.swift
//  bubble-jam
//
//  Created by Otávio Albuquerque on 06/12/22.
//

import Foundation

struct DatetimeService: DateServicing {
    
    let calendar: Calendar!
    
    init(calendar: Calendar = Calendar.current) {
        self.calendar = calendar
    }
    
    var limitDate: DateComponents =  {
        var dateComponent = DateComponents()
        dateComponent.day = 12
        dateComponent.month = 12
        dateComponent.year = 2022
        return dateComponent
    }()
    
    func getCurrentDate() -> Date {
        return Date.now
    }
    
    func daysRemaining() -> Int {
        let date = getCurrentDate()
        let deadline = Calendar.current.date(from: limitDate)!
        let daysRemaining = calendar.dateComponents([.day,.month,.year], from: date, to: deadline)
        return daysRemaining.day! + 1
        
    }
    

}
