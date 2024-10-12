//
//  ImageCollectionCard.swift
//  Cleanup
//
//  Created by Kunal Personl on 28/09/24.
//

import SwiftUI

struct ImageCard : View {
    let imageObject : ImageModel
    @State var image = UIImage(named: "test")!
    
    var body: some View{
        VStack{
            Image(uiImage:image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .cornerRadius(10)
            
        }
        .onAppear {
            Utility.performAsync(delay: 0.1) {
                image = imageObject.asset?.getThumgImage() ?? UIImage(named: "test")!
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
                Text("\(imageInfo.images.count) Similar  : \(imageInfo.totalSize()) MB")
                Spacer()
            }
            ScrollView(.horizontal){
                LazyHStack {
                    ForEach(imageInfo.images, id: \.id) { item in
                        VStack{
                            
                            ImageCard(imageObject: item)
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
