//
//  RootAppScreen.swift
//  PharmaVision
//
//  Created by Kunal Personl on 25/08/24.
//

import SwiftUI

struct RootAppScreen<Content:View>: View {
    
    let content : Content
    
    @State private var showLoader : Int = 0

    init(@ViewBuilder content : () -> Content) {
        self.content = content()
    }
    
    func valueToPrint() -> String{
        return "Load value \(showLoader)"
    }
    
    var loader : some View {
        
        ZStack {
            Color.black.opacity(0.4)
            ZStack{
                ProgressView("Loading...")
                    .foregroundColor(.white)
                    .controlSize(.large )
                    .tint(.white)
                    .progressViewStyle(.circular)
                    .frame(width: 100,height: 100)
            }
        }
        
    }

    var body: some View {
        ZStack {
            content
                .withProgressView()
//            if AppState.shared?.isDataLoading == true {
//                loader
//            }
            
        }
        .onAppear(perform: {
//            LoadingState.shared.isLoading = true
//                   
//                   // Simulate an API call delay
//                   DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                       LoadingState.shared.isLoading = false
//                   }
        })
        .onPreferenceChange(DataLoaderPreferenceKey.self, perform: { value in
            print("PreferenceChange \(value)")
            self.showLoader = value
        })
        
    }
}


extension View {
    func showLoader( _ loader : Int) -> some View {
        return self
            .preference(key: DataLoaderPreferenceKey.self, value: loader)
    }
}



struct DataLoaderPreferenceKey : PreferenceKey {
    static var defaultValue: Int = -1

    static func reduce(value: inout Int, nextValue: () -> Int) {
        value = nextValue()
    }
}


#Preview {
    RootAppScreen{
        Text("Test content")
    }
}
