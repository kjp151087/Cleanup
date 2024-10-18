//
//  SimilarPhotoScreenViewModel.swift
//  Cleanup
//
//  Created by Kunal Personl on 02/10/24.
//

import Foundation


class SimilarPhotoScreenViewModel : ObservableObject {
    
    @Published var similarPhotos: [GridModel] = []
    
    func fetchPhotos() {
        print("fetchPhotos")
        if (PhotoKitManager.shared.isAccessGranted) {
            self.similarPhotos = PhotoKitManager.shared.similarPhotosList
            if (PhotoKitManager.shared.isScaning) {
                Utility.performAsync(delay: 0.5) { [weak self] in
                    self?.fetchPhotos()
                }
            }
        }
    }
    
}
