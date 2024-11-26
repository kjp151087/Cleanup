//
//  PhotoScreenViewModel.swift
//  Cleanup
//
//  Created by Kunal Personl on 13/10/24.
//

import Foundation
import SwiftUI
import Photos


class PhotoScreenViewModel : ObservableObject {
    
    @Published var photos: [PhotoAssetModel] = []
    
    init(assetList : [PhotoAssetModel]) {
//        self.photos = PhotoKitManager.shared.fetchAsset(for: .image)
        self.photos =  assetList
    }
}
