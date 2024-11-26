//
//  AssetImageView.swift
//  Cleanup
//
//  Created by Kunal Personl on 10/10/24.
//

import SwiftUI
import Photos

struct AssetImageView: View {
    var asset: PHAsset
    var shouldLoadOrigin: Bool = false
    var shouldReleaseOnDisapper: Bool = false
    var indexOfList: Int = -1
    
    @State private var isVisiable = false
    
    @State private var image: UIImage? = nil
    
    var body: some View {
        VStack {
            if let image = image {
                if (shouldLoadOrigin){
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }
                else {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                }
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .onAppear {
                        loadAssetImage()
                    }
            }
        }
        .onAppear {
//            print("on    appear \(indexOfList) \(shouldLoadOrigin) \(shouldReleaseOnDisapper)")
            self.isVisiable = true
        }
        .onDisappear {
//            print("on disappear \(indexOfList) \(shouldLoadOrigin) \(shouldReleaseOnDisapper)")
            if (shouldReleaseOnDisapper) {
//                print("on disappear releasing image \(indexOfList)")
                image = nil
            }
            self.isVisiable = false
        }
    }
    
    private func loadAssetImage() {
        let delay = shouldReleaseOnDisapper ? 0.1 : 0

        Utility.performInBackground(delay: delay) {
            var image = asset.getThumgImage()
            if (shouldLoadOrigin) {
                image = asset.getLargeImage()
            }
            else {
                self.loadLargeThumbImage()
            }
            DispatchQueue.main.async {
                if (isVisiable){
                    self.image = image
                }
            }
        }
    }
    
    private func loadLargeThumbImage(){
//        print("loadLargeThumbImage \(isVisiable)")
        let image = asset.getMedumThumgImage()
        DispatchQueue.main.async {
            if (isVisiable){
                Utility.performAsync(delay: 0.3) {
                    self.image = image
                }
                
            }
        }
    }
}
