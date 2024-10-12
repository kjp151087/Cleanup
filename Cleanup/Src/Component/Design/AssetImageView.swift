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
    
    @State private var image: UIImage? = nil
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .onAppear {
                        loadAssetImage()
                    }
            }
        }
    }
    
    private func loadAssetImage() {
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.isSynchronous = false
        options.deliveryMode = .highQualityFormat
        manager.requestImage(for: asset,
                             targetSize: CGSize(width: 80, height: 80),
                             contentMode: .aspectFill,
                             options: options) { image, _ in
            self.image = image
        }
    }
}
