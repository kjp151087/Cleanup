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
    
    @Published var photos: [PhotoAssetModel] = []
    @Published var currentImage: UIImage?
    var index : Int
    
//    init(index : Int) {
//        self.photos = PhotoKitManager.shared.fetchAsset(for: .image)
//        self.index = index
//        self.currentImage = photos[index].getLargeImage()
//    }
    
    init(index : Int, assetList : [PhotoAssetModel]?) {
        self.photos = assetList ?? []
        self.index = index
        
        print("self.photos \(self.photos.count)")
        print("index \(index)")
        self.currentImage = photos[index].asset.getLargeImage()
    }
    
    func getCurrentIndexAsset() -> PhotoAssetModel {
        return self.photos[index]
    }
    
    func updateToNextIndex(){
        index += 1
        self.currentImage = photos[index].asset.getLargeImage()
    }
    
    func getNextIndexAsset() -> PhotoAssetModel {
        return self.photos[index]
    }
}
