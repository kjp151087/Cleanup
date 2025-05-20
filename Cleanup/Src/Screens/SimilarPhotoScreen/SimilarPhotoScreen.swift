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
                    ForEach(vm.similarPhotos, id: \.id) { item in
                        VStack{
                            ImageCollectionCard(imageInfo: item) { index, selection in
                                print("check index \(index), \(selection)")
                                
                                for i in vm.similarPhotos[index].images{
                                    print( " i1 -> \(i.isSelected)")
                                }
                                
                                vm.similarPhotos[index].images.first?.isSelected = !(vm.similarPhotos[index].images.first?.isSelected ?? selection)
                                
                                
                                for i in vm.similarPhotos[index].images{
                                    print( " i2 -> \(i.isSelected)")
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
