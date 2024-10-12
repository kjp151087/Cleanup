//
//  StringExtension.swift
//  PharmaVision
//
//  Created by Kunal Personl on 03/09/24.
//

import Foundation
import SwiftUI

extension String {
    
    func isValidEmail() -> Bool{
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
        
    }
    
    func checkFirstCharacterNumber() -> Bool {
        let str = self.replacingOccurrences(of: "+", with: "")
        
        guard let firstChar = str.first else {
            return false
        }
        
        if CharacterSet.letters.contains(firstChar.unicodeScalars.first!) {
            return false
        } else if CharacterSet.decimalDigits.contains(firstChar.unicodeScalars.first!) {
            return true
        } else {
            return false
        }
    }
}


extension UIApplication {
    func endEditing() {
        self.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
