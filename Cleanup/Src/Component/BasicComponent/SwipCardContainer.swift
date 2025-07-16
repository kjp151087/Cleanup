//
//  SwipCardContainer.swift
//  Cleanup
//
//  Created by Kunal Personl on 16/07/25.
//


import SwiftUI

struct SwipCardContainer : View {
    
    var data : [String] = []
    
    var maxCard = 10

    @State var photos : [PhotoAssetModel] = []
    @State var currentIndex = 0
    @State private var currentCardData : [String] = []
    @State private var currentPhotoData : [PhotoAssetModel] = []
    

    func updateCardList() {
        var cardModels: [PhotoAssetModel] = []
        for i in currentIndex..<photos.count where cardModels.count < maxCard {
            cardModels.append(photos[i])
        }
        withAnimation {
            currentPhotoData = cardModels
        }
        
    }
    
    var cardView : some View {
        
        ZStack {
            
            ForEach(currentPhotoData.reversed(), id: \.asset.localIdentifier) { photoObj in
                SwipCardView(
                    id: photoObj.asset.localIdentifier,
                    actionToDelete: { id in
                        
                    },
                    actionToAdd: { id in
                        
                        
                    },
                    swipingInProgress: { direction in
                        
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
                            AssetImageView(asset: photoObj.asset, shouldLoadOrigin: true)
                            VStack {
                                HStack {
                                    Text("Delete")
                                    Spacer()
                                    Text("Keep")
                                }
                                Spacer()
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
