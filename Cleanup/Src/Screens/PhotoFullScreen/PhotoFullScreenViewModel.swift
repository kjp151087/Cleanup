//
//  PhotoFullScreenViewModel.swift
//  Cleanup
//
//  Created by Kunal Personl on 16/10/24.
//

import Foundation
import Photos
import UIKit

class PhotoFullScreenViewModel : ObservableObject {
    
    @Published var photos: [PHAsset] = []
    @Published var currentImage: UIImage?
    var index : Int
    
//    init(index : Int) {
//        self.photos = PhotoKitManager.shared.fetchAsset(for: .image)
//        self.index = index
//        self.currentImage = photos[index].getLargeImage()
//    }
    
    init(index : Int, assetList : [PHAsset]?) {
        self.photos = assetList ?? PhotoKitManager.shared.fetchAsset(for: .image)
        self.index = index
        self.currentImage = photos[index].getLargeImage()
    }
    
    func getCurrentIndexAsset() -> PHAsset {
        return self.photos[index]
    }
    
    func updateToNextIndex(){
        index += 1
        self.currentImage = photos[index].getLargeImage()
    }
    
    func getNextIndexAsset() -> PHAsset {
        return self.photos[index]
    }
}
