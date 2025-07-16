//
//  SwipCardView.swift
//  Cleanup
//
//  Created by Kunal Personl on 16/07/25.
//

import SwiftUI

enum SwipDirection : Int {
    
    case none = 0
    case left = 1
    case right = 2
    
}

/// A swipe‑to‑act card.
/// The parent supplies `content` (anything that is a `View`).
struct SwipCardView<Content: View>: View {
    
    let id: String
    var actionToDelete: (String) -> Void
    var actionToAdd:    (String) -> Void
    var swipingInProgress : (SwipDirection) -> Void
    var swipingCompleted : (SwipDirection) -> Void
    @ViewBuilder let content: () -> Content
    
    // MARK: – Private state
    @State private var offset = CGSize.zero
    @State private var colour = Color.white
    @State private var swipeDirection = SwipDirection.none
    
    // MARK: – Body
    var body: some View {
        ZStack {
            // Card chrome (stays inside the component)
            Rectangle()
                .cornerRadius(4)
                .foregroundStyle(colour.opacity(0.8))
                .overlay(                                     // <- put the parent’s UI on top
                    content()
                        .padding()                             // contents‑only padding
                )
                .shadow(radius: 4)
        }
        .offset(x: offset.width, y: offset.height * 0.2)
        .padding(10)
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
        case -500 ... -80:
            offset.width = -500
            actionToDelete(id)
            swipingCompleted(.left)
        case 80 ... 500:
            offset.width = 500
            actionToAdd(id)
            swipingCompleted(.right)
        default:
            offset = .zero
            swipingCompleted(.none)
        }
    }
    
    private func changeColour(for width: CGFloat) {
        switch width {
        case -500 ... -80: do {
            colour = .red
            swipeDirection = .left
            swipingInProgress(swipeDirection)
        }
        case 80 ... 500:   do {
            colour = .green
            swipeDirection = .right
            swipingInProgress(swipeDirection)
        }
        default: do {
            colour = .white
            swipeDirection = .none
            swipingInProgress(swipeDirection)
        }
        }
    }
}
