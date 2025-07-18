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
    @Published var title : String = ""
    
    init(assetList : [PhotoAssetModel], title : String) {
        self.photos = assetList
        self.title = title
    }
}
