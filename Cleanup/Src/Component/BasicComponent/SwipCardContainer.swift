//
//  SwipCardContainer.swift
//  Cleanup
//
//  Created by Kunal Personl on 16/07/25.
//


import SwiftUI

struct SwipCardContainer : View {
    
    var data : [String] = []
    
    var maxCard = 4

    @State var photos : [PhotoAssetModel] = []
    @State var currentIndex = 0
    @State private var currentCardData : [String] = []
    @State private var currentPhotoData : [PhotoAssetModel] = []
    
    @State var isDeleteTextVisible = false
    @State var isKeepTextVisible = false

    func updateCardList() {
        var cardModels: [PhotoAssetModel] = []
        for i in currentIndex..<photos.count where cardModels.count < maxCard {
            cardModels.append(photos[i])
        }
        withAnimation {
            
            currentPhotoData = cardModels.reversed()
            
        }
        
    }
    
    var cardView : some View {
        
        ZStack {
            
            ForEach(Array(currentPhotoData.enumerated()), id: \.element.asset.localIdentifier) { index, photoObj in

                SwipCardView(
                    id: photoObj.asset.localIdentifier,
                    swipingInProgress: { direction in
                        
                        isDeleteTextVisible = direction == .left
                        isKeepTextVisible = direction == .right
                        
                    },
                    swipingCompleted: { direction in
                        if (direction != .none) {
                            currentIndex += 1
                            updateCardList()
                            
                            if (direction == .left) {
                                PhotoKitManager.shared.deleteAsset(asset: photoObj)
                            }
                        }
                    }
                ) {
                    VStack(spacing: 12) {
                        ZStack {
                            if (photoObj.asset.mediaType == .video && index == (currentPhotoData.count - 1)) {
                                AssetVideoView(asset: photoObj.asset, shouldLoadOrigin: true)
                            }
                            else {
                                AssetImageView(asset: photoObj.asset, shouldLoadOrigin: true)
                            }
                        }
                    }
                }
                .padding(.vertical, 8)
            }
        }
        
    }
    
    var body: some View {
        ZStack {
            cardView
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.updateCardList()
            }
        }

    }
}

struct SwipCardView_preview : PreviewProvider {
    static var previews: some View {
        SwipCardContainer(photos: [])
    }
}
