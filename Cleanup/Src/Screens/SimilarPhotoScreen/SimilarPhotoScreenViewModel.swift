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
                
                Utility.performAsync(delay: 2) {
                    self.testingUpdate()
                }
            }
        }
    }
    
    func testingUpdate() {
        
        
        
//
//        var test = similarPhotos
//        similarPhotos[2].images[1].isSelected = false
//        similarPhotos = [test.first!]
//        
//        var test : [GridModel] = []
//        
//        for obj in similarPhotos {
//            var newObjList : [ImageModel] = []
//            
//            for ite in obj.images {
//                var a = ite
//                a.isSelected = false
//                newObjList.append(a)
//            }
//            
//            let obj = GridModel(index: 0, images: newObjList)
//            test.append(obj)
//        }
//        
//        similarPhotos = test
        
//        for item in similarPhotos[2].images {
//            item.isSelected = false
//        }
        
    }
    
    func updateSimilarPhotos(_ photos: [GridModel]) {
        self.similarPhotos = photos
    }
    
}
