//
//  GridModel.swift
//  Cleanup
//
//  Created by Kunal Personl on 19/10/24.
//

import Foundation
import UIKit
import PhotosUI
import SwiftUI


struct GridModel: Identifiable {
    var id = UUID() // Unique identifier
    var images: [ImageModel] = []
    var index: Int = -1
    
    init(index: Int, images: [ImageModel]) {
        self.images = images
        self.index = index
        
        setDefaultSelection()
    }
    
    init(uuidString : String, index: Int, images: [ImageModel]) {
        self.id = UUID(uuidString: uuidString) ?? UUID()
        self.images = images
        self.index = index

        setDefaultSelection()
    }
    
    func setDefaultSelection() {
        for i in 0..<self.images.count {
            self.images[i].isSelected = i != 0
        }
    }
    
    func saveDataToCache() {
        for item in images {
            DataManager.shared.updateScanID(assetID: item.asset?.localIdentifier ?? "", parentID: self.id.uuidString)
        }
    }
}


//
//struct GridModel : Identifiable {
//    
//    var id = UUID() // Unique identifier
//
//    var images : [ImageModel] = []
//    var index : Int = -1
//    
//    init(index : Int, images: [ImageModel]) {
//        self.images = images
//        self.index = index
//        
//        for i in 0..<self.images.count {
//            self.images[i].isSelected = i != 0
//        }
//    }
//    
////    func totalSize() -> Float {
////        var total  :Float = 0.0
////
////        for item in images {
////            total += item.asset?.assetSize() ?? 0.0
////        }
////
////        return total;
////    }
//}
