//
//  SimilarPhotoScreen.swift
//  Cleanup
//
//  Created by Kunal Personl on 02/10/24.
//

import SwiftUI

struct SimilarPhotoScreen: View {
    @StateObject var vm = SimilarPhotoScreenViewModel()
    
    @Environment(\.router) var router
    
    
    var scrollContent : some View {
        ScrollView {
            LazyVStack {
                
                ForEach(Array(vm.similarPhotos.enumerated()), id: \.element.id) { listIndex, item in
                    VStack {
                        ImageCollectionCard(imageInfo: item) { innerIndex, selection in
                            
                            let updatedPhotos = vm.similarPhotos
                            updatedPhotos[listIndex].images[innerIndex].isSelected = selection
                            
                            vm.updateSimilarPhotos(updatedPhotos)
                        }
                        Divider()
                    }
                }
            }
        }
    }
    
    var header : some View {
        VStack {
            HStack {
                TextButton(action: {
                    router.dismissScreenStack()
                }, text: "Back", isEnable: .constant(true))
                Spacer()
                if (vm.count > 0) {
                    VStack{
                        TextButton(action: {
                            vm.deleteSelectedPhotos()
                        }, text: "Delete \(vm.count)", isEnable: .constant(true))
                        Text("Total - \(vm.totalMemorySaved)")
                    }
                }
            }
        }
    }
    
    var body: some View {
        VStack {
            header
            scrollContent
        }
        .navigationBarBackButtonHidden()
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
