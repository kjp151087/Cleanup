//
//  DateExtension.swift
//  PharmaVision
//
//  Created by Kunal Personl on 10/09/24.
//

import Foundation

extension Date {
    
    static func currentDateTime() -> String {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM HH:mm"

        let date = Date()

        return dateFormatter.string(from: date)
    }
}
