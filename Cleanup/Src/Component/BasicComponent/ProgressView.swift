//
//  ProgressView.swift
//  PharmaVision
//
//  Created by Kunal Personl on 25/08/24.
//

import SwiftUI


class LoadingState: ObservableObject {
    static let shared = LoadingState()
    
    @Published var isLoading: Bool = false
    
    private init() {}
    
    
    func startLoading() {
        DispatchQueue.main.async {
            LoadingState.shared.isLoading = true
        }
        
    }

    func stopLoading() {
        DispatchQueue.main.async {
            LoadingState.shared.isLoading = false
        }
        
    }

}


struct ProgressViewModifier: ViewModifier {
    @ObservedObject var loadingState = LoadingState.shared
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(loadingState.isLoading)
                .blur(radius: loadingState.isLoading ? 3 : 0)
            
            if loadingState.isLoading {
                VStack {
                    ProgressView("Loading...")
                        .tint(.white)
                        .foregroundColor(.white)
                        .progressViewStyle(CircularProgressViewStyle())
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.4))
            }
        }
    }
}

extension View {
    func withProgressView() -> some View {
        self.modifier(ProgressViewModifier())
    }
}

