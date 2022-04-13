//
//  String + DateFormatter.swift
//  SpaceX
//
//  Created by Даня on 12.04.2022.
//

import Foundation

extension String {
    func getFormattedDateString(oldFormat: String, format: String) -> String {
        let stringDateFormatter = DateFormatter()
        stringDateFormatter.dateFormat = oldFormat
        let date = stringDateFormatter.date(from: self)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: date ?? Date())
    }
}
