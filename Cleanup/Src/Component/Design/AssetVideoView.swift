//
//  AssetVideoView.swift
//  Cleanup
//
//  Created by Kunal Personl on 17/07/25.
//


import SwiftUI
import Photos
import AVKit

struct AssetVideoView: View {
    var asset: PHAsset
    var shouldLoadOrigin: Bool = false
    var shouldReleaseOnDisappear: Bool = false
    var indexOfList: Int = -1

    @State private var player: AVPlayer? = nil
    @State private var isVisible = false

    var body: some View {
        VStack {
            if let player = player {
                ZStack{
                    VideoPlayer(player: player)
                }
            } else {
                ZStack{
                    Rectangle()
                        .fill(Color.black.opacity(0.3))
                        .onAppear {
                            loadVideo()
                        }
                    Text("Please is not ready")
                }
            }
        }
        .onAppear {
            isVisible = true
        }
        .onDisappear {
            if shouldReleaseOnDisappear {
                player?.pause()
                player = nil
            }
            isVisible = false
        }
    }

    private func loadVideo() {
        let options = PHVideoRequestOptions()
        options.isNetworkAccessAllowed = true
        options.deliveryMode = shouldLoadOrigin ? .highQualityFormat : .automatic

        PHImageManager.default().requestAVAsset(forVideo: asset, options: options) { avAsset, _, _ in
            guard let avAsset = avAsset, isVisible else { return }

            let playerItem = AVPlayerItem(asset: avAsset)
            let player = AVPlayer(playerItem: playerItem)

            DispatchQueue.main.async {
                self.player = player
            }
        }
    }
}
