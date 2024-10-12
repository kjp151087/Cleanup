//
//  PHAssetExtension.swift
//  Cleanup
//
//  Created by Kunal Personl on 28/09/24.
//

import Foundation
import Vision
import UIKit
import Photos

extension PHAsset {
    
    func assetSize() -> Float {
        return 0
        let imageManager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        options.deliveryMode = .highQualityFormat
        var bytes : Int = 0
        
        imageManager.requestImageData(for: self, options: options) { (data, _, _, _) in
            if let data = data {
                bytes =  data.count
            }
        }
        
        return Float(bytes) / (1024 * 1024)
    }
    
    func getImage(targetSize : CGSize = CGSize(width: 200, height: 200)) -> UIImage? {
        
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        let imageManager = PHImageManager.default()
        var fetchImage : UIImage?
        
        imageManager.requestImage(for: self, targetSize: targetSize, contentMode: .aspectFit, options: options) { image, _ in
            
            if let image = image {
                fetchImage = image
            }
        }
        
        return fetchImage
    }
    
    func getLargeImage() -> UIImage? {
        return getImage(targetSize: CGSize(width: 5000, height: 5000))
    }
    
    func getThumgImage() -> UIImage? {
        return getImage(targetSize: CGSize(width: 100, height: 100))
    }
    
    func getMediumImage() -> UIImage? {
        return getImage(targetSize: CGSize(width: 500, height: 500))
    }
}
