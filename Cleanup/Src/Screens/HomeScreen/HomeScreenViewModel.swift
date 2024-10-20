//
//  HomeScreenViewModel.swift
//  Cleanup
//
//  Created by Kunal Personl on 26/09/24.
//

import Foundation
import UIKit
import PhotosUI







class HomeScreenViewModel : ObservableObject {
    
//    @Published var fetchedPhotos: [GridModel] = []
    @Published var photos: [PHAsset] = []
    @Published var videos: [PHAsset] = []
    @Published var livePhotos: [PHAsset] = []
    @Published var screenshots: [PHAsset] = []
    @Published var deletedPhotos: [PHAsset] = []
    
    @Published var chartData: [ChartInfo] = []
    
    
    @Published var progress: Float = 0
    
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
        deletedPhotos = PhotoKitManager.shared.deletedPhotoList
        
        PhotoKitManager.shared.requestPermission { isGranted in
            PhotoKitManager.shared.filterSimilarPhotos { newList, isAllImageProcess in
                self.progress = PhotoKitManager.shared.scanningProgress
//                self.fetchedPhotos = newList
            }
        }
        
        Utility.performAsync(delay: 1) { [weak self] in
//            self?.countSizeOnDisk()
        }
    }
    
    func countSizeOnDisk() {
        
        
        DispatchQueue.global().async {
            
            var data : [ChartInfo] = []
            
            
            let videosSize = Double(PhotoKitManager.shared.totalSizeOnDisk(assets: self.videos))
            data.append(ChartInfo(value: videosSize, color: .green, text: "Videos\n\(Utility.formatDiskSize(size: videosSize))"))
            
            DispatchQueue.main.async {
                self.chartData = data
            }
            
            
            let photosSize = Double(PhotoKitManager.shared.totalSizeOnDisk(assets: self.photos))
            data.append(ChartInfo(value: photosSize, color: .blue, text: "Photos\n\(Utility.formatDiskSize(size: photosSize))"))
            
            DispatchQueue.main.async {
                self.chartData = data
            }
            
            let livePhotoSize = Double(PhotoKitManager.shared.totalSizeOnDisk(assets: self.livePhotos))
            data.append(ChartInfo(value: livePhotoSize, color: .orange, text: "Live Photos\n\(Utility.formatDiskSize(size: livePhotoSize))"))
            
            DispatchQueue.main.async {
                self.chartData = data
            }
            
            
            let screenShotSize = Double(PhotoKitManager.shared.totalSizeOnDisk(assets: self.screenshots))
            data.append(ChartInfo(value: screenShotSize, color: .purple, text: "Screen Shots\n\(Utility.formatDiskSize(size: screenShotSize))"))
        
            
            DispatchQueue.main.async {
                self.chartData = data
            }
//
//            let data = [
//                ChartInfo(value: photosSize, color: .blue, text: "Photos\n\(photosSize) MB"),
//                ChartInfo(value: videosSize, color: .green, text: "Videos"),
//                ChartInfo(value: livePhotoSize, color: .orange, text: "Live Photos"),
//                ChartInfo(value: screenShotSize, color: .purple, text: "Screen Shots"),
//            ]
            
        }
        
    }
    
}
