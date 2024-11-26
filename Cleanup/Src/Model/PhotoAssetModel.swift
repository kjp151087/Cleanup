//
//  PhotoAsset.swift
//  Cleanup
//
//  Created by Kunal Personl on 16/10/24.
//

import Foundation
import Photos
import UIKit

class PhotoAssetModel : Identifiable  {
    var id = UUID() // Unique identifier

    var selected : Bool = false
    var asset : PHAsset
    
    init(asset: PHAsset) {
        self.selected = false
        self.asset = asset
    }
}
