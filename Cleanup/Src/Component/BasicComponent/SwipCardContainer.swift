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
        currentPhotoData = cardModels
    }
    
    var cardView : some View {
        
        ZStack {
            
            ForEach(currentPhotoData.reversed(), id: \.asset.localIdentifier) { photoObj in
                SwipCardView(
                    id: photoObj.asset.localIdentifier,
                    actionToDelete: { id in
                        PhotoKitManager.shared.deleteAsset(asset: photoObj)
                        currentIndex += 1
                        updateCardList()
                    },
                    actionToAdd: { id in
                        
                        currentIndex += 1
                        updateCardList()
                    }
                ) {
                    VStack(spacing: 12) {
                        AssetImageView(asset: photoObj.asset, shouldLoadOrigin: true)
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

/// A swipe‑to‑act card.
/// The parent supplies `content` (anything that is a `View`).
struct SwipCardView<Content: View>: View {
    
    let id: String
    var actionToDelete: (String) -> Void
    var actionToAdd:    (String) -> Void
    @ViewBuilder let content: () -> Content
    
    // MARK: – Private state
    @State private var offset = CGSize.zero
    @State private var colour = Color.black
    
    // MARK: – Body
    var body: some View {
        ZStack {
            // Card chrome (stays inside the component)
            Rectangle()
                .cornerRadius(4)
                .foregroundStyle(colour.opacity(0.01))
                .overlay(                                     // <- put the parent’s UI on top
                    content()
                        .padding()                             // contents‑only padding
                )
                .shadow(radius: 4)
        }
        .offset(x: offset.width, y: offset.height * 0.2)
        .rotationEffect(.degrees(Double(offset.width / 80)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    withAnimation { changeColour(for: offset.width) }
                }
                .onEnded { _ in
                    withAnimation {
                        handleSwipe(for: offset.width)
                        changeColour(for: offset.width)
                    }
                }
        )
    }
    
    // MARK: – Helpers
    private func handleSwipe(for width: CGFloat) {
        switch width {
        case -500 ... -150:
            offset.width = -500
            actionToDelete(id)
        case 150 ... 500:
            offset.width = 500
            actionToAdd(id)
        default:
            offset = .zero
        }
    }
    
    private func changeColour(for width: CGFloat) {
        switch width {
        case -500 ... -100: colour = .red
        case 100 ... 500:   colour = .green
        default:            colour = .black
        }
    }
}


struct SwipCardView_preview : PreviewProvider {
    static var previews: some View {
        SwipCardContainer(photos: [])
    }
}
