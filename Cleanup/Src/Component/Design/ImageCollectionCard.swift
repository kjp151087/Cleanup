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

struct ImageCollectionCard: View {
    
    let imageInfo :  GridModel
    @State var image = UIImage(named: "test")
    
    var body: some View {
        VStack{
            HStack{
//                Text("\(imageInfo.images.count) Similar  : \(imageInfo.totalSize()) MB")
                Text("\(imageInfo.images.count) Similar")
                Spacer()
            }
            ScrollView(.horizontal){
                LazyHStack {
                    ForEach(imageInfo.images, id: \.id) { item in
                        VStack{
                            if let asset = item.asset {
                                AssetImageView(asset: asset)
                                    .frame(width: 120, height: 120)
                                    .cornerRadius(8)
                            }
                            Text("DP: \(String(format: "%0.2f", item.deltaImageProcess))")
                            Text("DT: \(String(format: "%0.2f", item.deltaImageTime))")
                            Text("FileSize: \(String(format: "%0.2f", item.asset?.assetSize() ?? 0))")
                            
                            
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
