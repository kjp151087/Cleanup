//
//  SimilarPhotoScreenViewModel.swift
//  Cleanup
//
//  Created by Kunal Personl on 02/10/24.
//

import Foundation


class SimilarPhotoScreenViewModel : ObservableObject {
    
    @Published var fetchedPhotos: [GridModel] = []
    @Published var isScaning = false
    
    func fetchPhotos() {
        
        print("fetchPhotos")
        PhotoKitManager.shared.requestPermission { isGranted in
            self.isScaning = true
            PhotoKitManager.shared.filterSimilarPhotos { newList, isAllImageProcess in
                print("newList",newList.count)
                self.fetchedPhotos = newList
                self.isScaning = !isAllImageProcess
            }
        }
    }
    
}
