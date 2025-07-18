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
            Rectangle()
                .cornerRadius(4)
                .foregroundStyle(colour.opacity(0.8))
                .overlay(
                    content()
                        
                )
                .shadow(radius: 4)
            
            VStack {
                HStack {
                    if (swipeDirection  == .right){
                        Text("Keep")
                            .font(.largeTitle)
                            .foregroundColor(Color.green.opacity(0.8))
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.green.opacity(0.8), lineWidth: 2)
                            )
                            
                    }
                    Spacer()
                    if (swipeDirection  == .left){
                        Text("Delete")
                            .font(.largeTitle)
                            .foregroundColor(Color.red.opacity(0.8))
                            .padding()
                            .overlay(                                      // white border
                                RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.red.opacity(0.8), lineWidth: 2)
                            )
                    }
                }
                .padding()
                Spacer()
            }
        }
        .offset(x: offset.width, y: offset.height * 0.2)
        .padding(8)
        .rotationEffect(.degrees(Double(offset.width / 80)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    swipeDirection = getCurrentDirection(width: offset.width)
                    swipingInProgress(swipeDirection)
                    withAnimation {
                        changeColour(direction: swipeDirection)
                    }
                }
                .onEnded { _ in
                    withAnimation {
                        handleSwipe(for: offset.width)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            swipingCompleted(swipeDirection)
                        }
                    }
                }
        )
    }
    
    private func getCurrentDirection(width: CGFloat) -> SwipDirection {
        switch width {
        case -500 ... -80:
            return .left
        case 80 ... 500:
            return .right
        default:
            return .none
        }
    }
    
    // MARK: – Helpers
    private func handleSwipe(for width: CGFloat) {
        switch width {
        case -500 ... -80:
            offset.width = -500
        case 80 ... 500:
            offset.width = 500
        default:
            offset = .zero
        }
    }
    
    private func changeColour(direction : SwipDirection) {
    }
}
