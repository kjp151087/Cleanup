//
//  GridModel.swift
//  Cleanup
//
//  Created by Kunal Personl on 19/10/24.
//

import Foundation
import UIKit
import PhotosUI


struct GridModel : Identifiable {
    
    var id = UUID() // Unique identifier

    var images : [ImageModel]
    var index : Int
    
    init(index : Int, images: [ImageModel]) {
        self.images = images
        self.index = index
    }
    
//    func totalSize() -> Float {
//        var total  :Float = 0.0
//
//        for item in images {
//            total += item.asset?.assetSize() ?? 0.0
//        }
//
//        return total;
//    }
}
