//
//  SimilarPhotoScreenViewModel.swift
//  Cleanup
//
//  Created by Kunal Personl on 02/10/24.
//

import Foundation
import Photos

class SimilarPhotoScreenViewModel : ObservableObject {
    
    @Published var similarPhotos: [GridModel] = []
    @Published var count = 0
    
    func fetchPhotos() {
//        print("fetchPhotos")
        if (PhotoKitManager.shared.isAccessGranted) {
            self.similarPhotos = PhotoKitManager.shared.similarPhotosList
            if (PhotoKitManager.shared.isScaning) {
                Utility.performAsync(delay: 0.5) { [weak self] in
                    self?.fetchPhotos()
                }
                
                Utility.performAsync(delay: 2) {
                    
                }
            }
        }
    }
    
    func updateSimilarPhotos(_ photos: [GridModel]) {
        var totalCount = 0
        var count = photos.flatMap{$0.images}.filter{$0.isSelected}.count
        for item in photos {
            for image in item.images {
                if image.isSelected {
                    print("total count ", totalCount)
                    totalCount += 1
                }
            }
        }
        self.count = totalCount
        self.similarPhotos = photos
    }
    
    func deleteSelectedPhotos() {
        
        let deleteAssets: [PHAsset] = similarPhotos
            .flatMap { $0.images }
            .filter { $0.isSelected }
            .compactMap { $0.asset }

        PhotoKitManager.shared.deleteAssetFromPhotos(assets: deleteAssets) { success, error in
            if (success) {
                DispatchQueue.main.async {
                    self.similarPhotos = PhotoKitManager.shared.updateListAfterDeleteAsset(assets: deleteAssets)
                    self.count = 0
                }
            }
            else{
                print("Error ", error)
            }
        }
    }
    
}
