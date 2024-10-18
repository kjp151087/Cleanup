//
//  Utility.swift
//  PharmaVision
//
//  Created by Kunal Personl on 10/09/24.
//

import Foundation


class Utility {
    
    static func performAsync(delay : TimeInterval, perform :@escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            perform()
        }
    }
    
    static  func changeAddCountryCode(_ tag: String) -> String {
        var tagged = tag
        print("changeAddCountryCode Start -> ",tagged)
        if validatePhone(tag) {
            if !tag.hasPrefix("+") && !tag.hasPrefix("00") && !tag.hasPrefix("1") {
                // If the phone number doesn't have country code and is 10 digits long
                if tag.count == 10 {
                    tagged = "+1\(tag)"  // Add +1 for US country code
                } else {
                    tagged = "+\(tag)"   // Add just the "+" for other numbers
                }
            } else if tag.hasPrefix("00") {
                // Replace "00" with "+"
                tagged = "+\(tag.dropFirst(2))"
            } else if tag.hasPrefix("1") {
                // Add the "+" to numbers starting with "1"
                tagged = "+\(tag)"
            } else {
                // No change needed
                tagged = tag
            }
        }
        print("changeAddCountryCode end -> ",tagged)
        return tagged
    }

    static func validatePhone(_ phoneNumber: String) -> Bool {
        // Check if the phone number length is within the valid range
        if phoneNumber.count > 13 || phoneNumber.count < 7 {
            return false
        }
        
        // Define a valid set of characters (numbers, symbols like +, space, etc.)
        let numbersOnly = CharacterSet(charactersIn: "+0123456789 -()")
        let characterSetFromTextField = CharacterSet(charactersIn: phoneNumber)
        
        // Check if the phone number contains only valid characters
        let stringIsValid = numbersOnly.isSuperset(of: characterSetFromTextField)
        return stringIsValid
    }
    
    static func formatDiskSize(size : Double) -> String {
        if (size > 1000) {
            return String(format: "%.2f GB", (size/1000.0))
        }
        return String(format: "%.2f MB", size)
    }


}
