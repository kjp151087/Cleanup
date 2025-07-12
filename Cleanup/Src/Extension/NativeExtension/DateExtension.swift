//
//  DateExtension.swift
//  PharmaVision
//
//  Created by Kunal Personl on 10/09/24.
//

import Foundation

extension Date {
    
    static func currentDateTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM HH:mm"

        let date = Date()

        return dateFormatter.string(from: date)
    }
    
    
    func formateDate(formatDate : String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatDate

        return dateFormatter.string(from: self)
    }
}
