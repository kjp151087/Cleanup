//
//  HomeScreenViewModel.swift
//  Cleanup
//
//  Created by Kunal Personl on 26/09/24.
//

import Foundation
import UIKit
import PhotosUI

struct GridModel : Identifiable {
    
    var id = UUID() // Unique identifier

    var images : [ImageModel]
    var index : Int
    
    init(index : Int, images: [ImageModel]) {
        self.images = images
        self.index = index
    }
    
    func totalSize() -> Float {
        var total  :Float = 0.0
        
        for item in images {
            total += item.asset?.assetSize() ?? 0.0
        }
        
        return total;
    }
}


struct ImageModel : Identifiable {
    
    var id = UUID() // Unique identifier
    var index : Int

    var asset : PHAsset?
    var image : UIImage?
    var deltaImageProcess : Float
    var deltaImageTime : Float
    
    init(index: Int, asset : PHAsset?, image: UIImage?, difValue : Float, deltaTime : Float) {
        self.image = image
        self.index = index
        self.asset = asset
        self.deltaImageProcess = difValue
        self.deltaImageTime = deltaTime
    }
}


class HomeScreenViewModel : ObservableObject {
    
    @Published var fetchedPhotos: [GridModel] = []
    @Published var photos: [PHAsset] = []
    @Published var videos: [PHAsset] = []
    @Published var livePhotos: [PHAsset] = []
    @Published var screenshots: [PHAsset] = []
    @Published var isScaning = false
    @Published var chartData: [ChartInfo] = []
    
    func requestPermission() {
        let status = PhotoKitManager.shared.status
        print("status ",status.rawValue)
        if (status == .notDetermined) {
            PhotoKitManager.shared.requestPermission { isGranted in
                print("isGranted ",isGranted)
                self.fetchPhotos()
            }
        }
        else if (status == .authorized || status == .limited) {
            self.fetchPhotos()
        }
    }
    
    func fetchPhotos() {
        
        photos = PhotoKitManager.shared.fetchAsset(for: .image)
        videos = PhotoKitManager.shared.fetchAsset(for: .video)
        livePhotos = PhotoKitManager.shared.fetchAsset(for: .image, subType: .photoLive)
        screenshots = PhotoKitManager.shared.fetchAsset(for: .image, subType: .photoScreenshot)
        
        chartData = [
            ChartInfo(value: Double(photos.count), color: .blue, text: "Photos"),
            ChartInfo(value: Double(videos.count), color: .green, text: "Videos"),
            ChartInfo(value: Double(livePhotos.count), color: .orange, text: "Live Photos"),
            ChartInfo(value: Double(screenshots.count), color: .purple, text: "Screen Shots"),
        ]
        
        PhotoKitManager.shared.requestPermission { isGranted in
            self.isScaning = true
            PhotoKitManager.shared.filterSimilarPhotos { newList, isAllImageProcess in
                self.fetchedPhotos = newList
                self.isScaning = !isAllImageProcess
            }
        }
    }
    
}
