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
    
    func getCurrentDate() async -> Date? {
        let url = URL(string: "https://www.google.com")!
        let request = URLRequest(url: url)
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            let httpRespone = response as? HTTPURLResponse
            if let content = httpRespone!.allHeaderFields["Date"] as? String {
                print(content)
                let formatter = DateFormatter()
                formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ssz"
                formatter.timeZone = TimeZone.current
                formatter.locale = Locale.current
                let serverDate = utcToLocal(dateStr: content)
                return serverDate
            } else {
                raise(1)
            }
        } catch {
            print("deu merda")
        }
        return nil
    }
    


    func utcToLocal(dateStr: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ssz"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = dateFormatter.date(from: dateStr) {
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ssz"
            dateFormatter.locale = Locale(identifier: "pt_BR")
        
            return date
        }
        return nil
    }
    
}
