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
            print("on    appear \(indexOfList) \(shouldLoadOrigin) \(shouldReleaseOnDisapper)")
            self.isVisiable = true
        }
        .onDisappear {
            print("on disappear \(indexOfList) \(shouldLoadOrigin) \(shouldReleaseOnDisapper)")
            if (shouldReleaseOnDisapper) {
                print("on disappear releasing image \(indexOfList)")
                image = nil
            }
            self.isVisiable = false
        }
    }
    
    private func loadAssetImage() {
        let delay : DispatchTime = shouldReleaseOnDisapper ? (.now() + 1) : .now()
        DispatchQueue.global().asyncAfter(deadline: delay){
            var image = asset.getMedumThumgImage()
            if (shouldLoadOrigin) {
                image = asset.getLargeImage()
            }
            DispatchQueue.main.async {
                if (isVisiable){
                    self.image = image
                }
            }
        }
    }
}
