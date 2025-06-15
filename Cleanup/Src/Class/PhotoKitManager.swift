//
//  PhotoKitAccess.swift
//  Cleanup
//
//  Created by Kunal Personl on 26/09/24.
//

import Foundation
import PhotosUI
import Vision
import Combine


class PhotoKitManager : ObservableObject {
    
    var testing = false
    
    static var shared = PhotoKitManager()
    
    var status : PHAuthorizationStatus = .notDetermined
    var photosList : [PhotoAssetModel] = []
    var videosList : [PhotoAssetModel] = []
    var deletedPhotoList : [PhotoAssetModel] = []
    var similarPhotosList : [GridModel] = []
    
    var isScaning = false
    var scanningProgress : Float = 0
    
    var isAccessGranted :Bool {
        switch self.status {
        case .authorized, .limited:
            return true
        case .denied, .restricted, .notDetermined:
            print("Access to photo library is not allowed.")
            return false
        @unknown default:
            print("Unknown photo library permission status.")
            return false
        }
    }
    
    private init() {
        status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        fetchAllAssetes()
        print("status ", status);
    }
    
    func requestPermission(handler: @escaping (Bool) -> Void) {
        PHPhotoLibrary.requestAuthorization { status in
            self.status = status
            switch status {
            case .authorized, .limited:
                handler(true)
            case .denied, .restricted, .notDetermined:
                print("Access to photo library is not allowed.")
                handler(false)
            @unknown default:
                print("Unknown photo library permission status.")
            }
        }
    }
    
    func fetchAllAssetes()  {
        photosList = self.fetchAsset(for: .image)
        videosList = self.fetchAsset(for: .video)
        
        let deletedList = DataManager.shared.deletedAssetList()
        for asset in photosList {
            let identifire = asset.asset.localIdentifier
            if deletedList.contains(identifire) {
                deletedPhotoList.append(asset)
            }
        }
    }
    
    func fetchAsset(for media:PHAssetMediaType) -> [PhotoAssetModel] {
    
        var fetchedPhotos: [PhotoAssetModel] = []
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let assets = PHAsset.fetchAssets(with: media, options: fetchOptions)
        
        for i in 0..<assets.count {
            fetchedPhotos.append(PhotoAssetModel(asset: assets[i]))
        }
        
        return fetchedPhotos
    }
    
    func fetchAsset(for media:PHAssetMediaType, subType : PHAssetMediaSubtype) -> [PhotoAssetModel] {
    
        var fetchedPhotos: [PhotoAssetModel] = []
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        fetchOptions.predicate = NSPredicate(format: "mediaType == %d AND (mediaSubtypes & %d) != 0",
                                             media.rawValue,
                                             subType.rawValue)

        
        let assets = PHAsset.fetchAssets(with: media, options: fetchOptions)
        
        for i in 0..<assets.count {
            fetchedPhotos.append(PhotoAssetModel(asset: assets[i]))
        }
        
        return fetchedPhotos
    }
    
    func totalSizeOnDisk(assets : [PhotoAssetModel]) -> Float{
        return assets.reduce(0) { result, item in
            result + item.asset.assetSize()
       }
    }

    
    func filterSimilarPhotos(updateList: @escaping ([GridModel],Bool) -> Void)  {
        
//        var fetchedPhotos: [GridModel] = []
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let assets = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        let imageManager = PHImageManager.default()
        
        var lastCreation = Date()
        var imageList : [ImageModel] = []
        var mainIndex = 0
        
        let startTime = Date()
        print("assets.count ",assets.count)
        
        var countLegnth = testing ? 350 : assets.count
        isScaning = true
        for i in 1..<countLegnth {
            scanningProgress = Float(i) / Float(countLegnth)
            autoreleasepool {
                 
                let image1 = assets[i-1].getThumgImage() ?? UIImage(named: "test")!
                let image2 = assets[i].getThumgImage() ?? UIImage(named: "test")!
                
                let distance = PhotoKitManager.shared.compareImage(image1: image1, image2: image2)
                let deltaTime = assets[i-1].creationDate!.timeIntervalSince1970 - assets[i].creationDate!.timeIntervalSince1970
                
                let widthDelta = abs(image1.size.width - image2.size.width)
                let heightDelta = abs(image1.size.height - image2.size.height)
                
//                print("distance -> \(distance) between \(i-1)-\(i)")
                
                if ((distance < 0.50 && deltaTime < 15) && (widthDelta < 10 && heightDelta < 10)) {
                    imageList.append(ImageModel(index:imageList.count, asset: assets[i], image: nil, difValue: distance, deltaTime: Float(deltaTime)))
                }
                else{
                    if(imageList.count > 1){
                        similarPhotosList.append(GridModel(index: mainIndex, images: imageList))
                        mainIndex += 1
                    }
                    imageList = []
                    imageList.append(ImageModel(index:imageList.count, asset: assets[i], image: nil, difValue: distance, deltaTime: Float(deltaTime)))
                    
                }
                
                if (i % 25 == 0) {
                    Utility.performAsync(delay: 0.1) { [weak self] in
                        if let list = self?.similarPhotosList{
                            updateList(list,false)
                        }
                        
                    }
                    
                }
                
//                print("Distance \(i) \(scanningProgress) \(distance) - \(widthDelta) - \(heightDelta) ")
            }
        }
        
        let endTime = Date()
        isScaning = false
        let times = endTime.timeIntervalSince1970 - startTime.timeIntervalSince1970
        print("times \(times)")
        updateList(similarPhotosList,true)
        
    }
    
    func getImageProcessSignature(image : UIImage) -> VNFeaturePrintObservation? {
        
        guard let cgImage = image.cgImage else { return nil }
        let request = VNGenerateImageFeaturePrintRequest()
        
        let orientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue)) ?? CGImagePropertyOrientation.up
        let requestHandler = VNImageRequestHandler(cgImage: cgImage,
                                                   orientation: orientation,
                                                   options: [:])
        do {
            try requestHandler.perform([request])
        } catch {
            print("Can't make the request due to \(error)")
        }
        
        guard let result = request.results?.first else { return nil }
        return result
        
    }
    
    private func compareImage(image1 : UIImage, image2 : UIImage) -> Float {
        
        var imageDistance: Float = .infinity
        
        if let imagePrint1 = getImageProcessSignature(image: image1) {
            if let imagePrint2 = getImageProcessSignature(image: image2) {
                do {
                    try imagePrint1.computeDistance(&imageDistance, to: imagePrint2)
                    return imageDistance
                } catch {
                    print("Couldn't compute the distance")
                }
            }
        }
        
        
        return imageDistance
    }
    
    func deleteAsset(asset : PhotoAssetModel) {
        deletedPhotoList.append(asset)
        DataManager.shared.deleteAssetId(assetID: asset.asset.localIdentifier)
    }
    
}
