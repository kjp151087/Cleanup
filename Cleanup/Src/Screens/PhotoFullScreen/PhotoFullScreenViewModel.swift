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
    @Published var title: String?
    var index : Int
    
    init(index : Int, assetList : [PhotoAssetModel]?, title : String?) {
        self.photos = assetList ?? []
        self.index = index
        self.title = title
        
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
