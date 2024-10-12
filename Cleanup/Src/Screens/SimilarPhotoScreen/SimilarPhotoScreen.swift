//
//  SimilarPhotoScreen.swift
//  Cleanup
//
//  Created by Kunal Personl on 02/10/24.
//

import SwiftUI

struct SimilarPhotoScreen: View {
    @StateObject var vm = SimilarPhotoScreenViewModel()

    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(vm.fetchedPhotos, id: \.id) { item in
                        VStack{
                            ImageCollectionCard(imageInfo: item)
                            Divider()
                        }
                    }
                }
            }
        }
        .padding()
        .onLoad {
            print("onload")
            vm.fetchPhotos()
        }
    }
}

#Preview {
    SimilarPhotoScreen()
}
