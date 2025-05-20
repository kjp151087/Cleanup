//
//  ImageModel.swift
//  Cleanup
//
//  Created by Kunal Personl on 19/10/24.
//

import Foundation
import Photos
import UIKit

class ImageModel: ObservableObject, Identifiable {
    
    var id = UUID() // Unique identifier
    var index : Int

    var asset : PHAsset?
    var image : UIImage?
    var deltaImageProcess : Float
    var deltaImageTime : Float
    @Published var isSelected: Bool = false 

    
    init(index: Int, asset : PHAsset?, image: UIImage?, difValue : Float, deltaTime : Float) {
        self.image = image
        self.index = index
        self.asset = asset
        self.deltaImageProcess = difValue
        self.deltaImageTime = deltaTime
    }
}
