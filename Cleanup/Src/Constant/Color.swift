//
//  Color.swift
//  PharmaVision
//
//  Created by Kunal Personl on 10/08/24.
//

import Foundation
import UIKit
import SwiftUI


extension Color {
    
    static func colorObject(red: Double, green: Double, blue: Double) -> Color {
        return Color(red: red/255.0, green: green/255.0, blue: blue/255.0)
    }
    
    static let textBlue = Color.colorObject(red: 54, green: 121, blue: 148)
    static let textDarkBlue = Color.colorObject(red: 0, green: 64, blue: 78)
    static let galleryBlueLight = Color.colorObject(red: 194, green: 233, blue: 254)
    static let galleryBlueLight2 = Color.colorObject(red: 235, green: 248, blue: 254)
    
    static let headerColor = Color.colorObject(red: 0, green: 64, blue: 78)
    static let loginButtonBGColor = Color.colorObject(red: 0, green: 64, blue: 78)
    
    static let grey100 = Color.colorObject(red: 100, green: 100, blue: 100)
    static let grey170 = Color.colorObject(red: 170, green: 170, blue: 170)
    static let grey240 = Color.colorObject(red: 240, green: 240, blue: 240)
    
    
    
    static let gallaryCardSubject = textBlue
    
}
