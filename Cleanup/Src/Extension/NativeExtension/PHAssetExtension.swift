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
    
    private static let bcf = ByteCountFormatter()


    func getSize(asset: PHAsset) -> String {
        let resources = PHAssetResource.assetResources(for: asset)

        guard let resource = resources.first,
              let unsignedInt64 = resource.value(forKey: "fileSize") as? CLong else {
                  return "Unknown"
              }

        let sizeOnDisk = Int64(bitPattern: UInt64(unsignedInt64))
        print("sizeOnDisk ",sizeOnDisk);
        print("sizeOnDisk ",Double(sizeOnDisk)/1000.0/1000.0);
        Self.bcf.allowedUnits = [.useMB]
        Self.bcf.countStyle = .file
        print("size ",Self.bcf.string(fromByteCount: sizeOnDisk));
        return Self.bcf.string(fromByteCount: sizeOnDisk)
    }

    
    func assetSize() -> Float {
        
            let resources = PHAssetResource.assetResources(for: self)
            
            guard let resource = resources.first,
                  let unsignedInt64 = resource.value(forKey: "fileSize") as? CLong else {
                      return 0
                  }

            let sizeOnDisk = Int64(bitPattern: UInt64(unsignedInt64))
            return Float(sizeOnDisk)/1000.0/1000.0;
            

        /// Below code not working
//        let imageManager = PHImageManager.default()
//        let options = PHImageRequestOptions()
//        options.isSynchronous = true
//        options.deliveryMode = .highQualityFormat
//        var bytes : Int = 0
//        
//        imageManager.requestImageData(for: self, options: options) { (data, _, _, _) in
//            if let data = data {
//                bytes =  data.count
//            }
//        }
//        return Float(bytes) / 1000.0 / 1000.0
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
    
    func getMedumThumgImage() -> UIImage? {
        return getImage(targetSize: CGSize(width: 300, height: 300))
    }
    
    func getMediumImage() -> UIImage? {
        return getImage(targetSize: CGSize(width: 500, height: 500))
    }
}
