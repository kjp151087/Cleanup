//
//  ImageCollectionCard.swift
//  Cleanup
//
//  Created by Kunal Personl on 28/09/24.
//

import SwiftUI
import Photos

struct ImageCard : View {
    let imageObject : PHAsset
    @State var image = UIImage(named: "test")!
    
    var body: some View{
        VStack{
            Image(uiImage:image)
                .resizable()
                .scaledToFill()
                .cornerRadius(10)
        }
        .background(.red)
        .onAppear {
            Utility.performAsync(delay: 0.1) {
                image = imageObject.getThumgImage() ?? UIImage(named: "test")!
            }
            
        }
        
    }
}

struct SimilarImageBox : View {
    @State var image : ImageModel
    @Environment(\.router) var router
    
    var selectionAction : ((Bool) -> ())?
    
    var body: some View {
        if let asset = image.asset {
            ZStack {
                
                Button {
                    if let image = asset.getLargeImage() {
                        router.showScreen(.push) { r in
                            ImageFullScreen(image: image)
                        }
                    }
                } label: {
                    AssetImageView(asset: asset)
                    .frame(width: 150, height: 150)
                    .cornerRadius(8)
                }

                VStack{
                    Spacer()
                    HStack() {
                        if image.isSelected {
                            CheckboxButton(checked: .constant(true), action: { selected in
                                selectionAction?(false)
                            })
                            .frame(width: 30, height: 30)
                        }
                        else  {
                            CheckboxButton(checked: .constant(false), action: { selected in
                                selectionAction?(true)
                            })
                            .frame(width: 30, height: 30)
                            
                        }
                        
                        Spacer()
                        VStack{
                            Text("\(String(format: "%0.2f", asset.assetSize() ?? 0)) MB")
                                .font(.subheadline)
                                .foregroundStyle(.white)
                        }
                        .padding(.horizontal,5)
                        .padding(.vertical,3)
                        .background(.black.opacity(0.5))
                        .cornerRadius(5, corners: .allCorners)
                    }
                }
                .padding(4)
                
            }
        }
        else{
            VStack{
                Text("No Data image box")
            }
        }
//                            Text("DP: \(String(format: "%0.2f", item.deltaImageProcess))")
//                            Text("DT: \(String(format: "%0.2f", item.deltaImageTime))")
//                            Text("FileSize: \(String(format: "%0.2f", item.asset?.assetSize() ?? 0))")
    }
}

struct ImageCollectionCard: View {
    
    @Environment(\.router) var router
    @State var imageInfo : GridModel
    @State var image = UIImage(named: "test")
    
    var selectionAction : ((Int,Bool) -> ())?
    
    var body: some View {
        VStack{
            HStack{
//                Text("\(imageInfo.images.count) Similar  : \(imageInfo.totalSize()) MB")
                Text("\(imageInfo.images.count) Similar")
                Spacer()
            }
            ScrollView(.horizontal){
                LazyHStack {
                    ForEach(Array(imageInfo.images.enumerated()), id: \.element.id) { index, item in
                        VStack {
                            SimilarImageBox(image: item) { selection in
                                print("Index: \(index), Selection: \(selection)")
//                                imageInfo.images[index].isSelected = selection
                                selectionAction?(index,selection)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            print("item display index \(imageInfo.index)")
        }
    }
}



#Preview {
    ImageCollectionCard(imageInfo: GridModel(index: 0, images: []))
}
