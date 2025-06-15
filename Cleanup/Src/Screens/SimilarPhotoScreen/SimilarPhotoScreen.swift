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
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    
                    ForEach(Array(vm.similarPhotos.enumerated()), id: \.element.id) { listIndex, item in
                        VStack {
                            ImageCollectionCard(imageInfo: item) { innerIndex, selection in
                                print("check index \(listIndex), \(selection)")
                                
                                for i in vm.similarPhotos[listIndex].images {
                                    print("i1 -> \(i.isSelected)")
                                }
//
                                var updatedPhotos = vm.similarPhotos
                                updatedPhotos[listIndex].images[innerIndex].isSelected.toggle()
                                
                                vm.updateSimilarPhotos(updatedPhotos)

                                for i in vm.similarPhotos[listIndex].images {
                                    print("i2 -> \(i.isSelected)")
                                }
                                
                                
                            }
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
