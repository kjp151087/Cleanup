//
//  ImageDetailView.swift
//  Cleanup
//
//  Created by Kunal Personl on 17/07/25.
//


import SwiftUI

struct ImageDetailView: View {
    let image: Image
    @State var scale = 1.0
    @State private var lastScale = 1.0
    private let minScale = 1.0
    private let maxScale = 5.0
    
    var magnification: some Gesture {
        MagnificationGesture()
            .onChanged { state in
                adjustScale(from: state)
            }
            .onEnded { state in
                withAnimation {
                    validateScaleLimits()
                }
                lastScale = 1.0
            }
    }

    var body: some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .scaleEffect(scale)
            .gesture(magnification)
    }
    
    func adjustScale(from state: MagnificationGesture.Value) {
        let delta = state / lastScale
        scale *= delta
        lastScale = state
    }
    
    func getMinimumScaleAllowed() -> CGFloat {
        return max(scale, minScale)
    }
    
    func getMaximumScaleAllowed() -> CGFloat {
        return min(scale, maxScale)
    }
    
    func validateScaleLimits() {
        scale = getMinimumScaleAllowed()
        scale = getMaximumScaleAllowed()
    }
}

struct ImageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDetailView(image: Image("car"))
    }
}
