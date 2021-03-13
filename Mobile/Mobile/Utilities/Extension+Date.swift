//
//  Extension+Date.swift
//  Mobile
//
//  Created by Cédric Bahirwe on 21/02/2021.
//

import Foundation

extension Date {
    /// Convert a given to to a string f-ormatted date `MMM dd, yyyy`
    var formatted: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        let stringDate = dateFormatter.string(from: self)
        return stringDate
    }
    
    /// Convert a date to a given string format
    /// - Parameter format: The format to be converted to conforming to the `DateFormats` enum
    /// - Returns: a formatted string in a date template format
    func formatTo(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let stringDate = dateFormatter.string(from: self)
        return stringDate
    }
}
