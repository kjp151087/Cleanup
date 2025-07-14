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
    @Published var totalMemorySaved : Float = 0
    
    func fetchPhotos() {

        if (PhotoKitManager.shared.isAccessGranted) {
            self.similarPhotos = PhotoKitManager.shared.similarPhotosList
            if (PhotoKitManager.shared.isScaning) {
                Utility.performAsync(delay: 0.5) { [weak self] in
                    self?.fetchPhotos()
                    self?.calculateSelectedImage()
                }
            }
            else{
                self.calculateSelectedImage()
            }
        }
    }
    
    func updateSimilarPhotos(_ photos: [GridModel]) {
        self.similarPhotos = photos
        calculateSelectedImage()
    }
    
    func calculateSelectedImage() {
        let quickCount = self.similarPhotos.flatMap{$0.images}.filter{$0.isSelected}.count
        self.count = quickCount
        self.recalculateSavedMemory()
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
    
    func recalculateSavedMemory() {
        var totalSize : Float = 0.0
        
        for item in similarPhotos {
            for image in item.images {
                if image.isSelected {
                    totalSize += image.asset?.cachedAssetSize() ?? 0.0
                    totalMemorySaved = totalSize
                }
            }
        }
        
        print("totalMemorySaved -> \(totalMemorySaved)")
    }
    
}
