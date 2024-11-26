//
//  HomeScreenCard.swift
//  Cleanup
//
//  Created by Kunal Personl on 04/10/24.
//

import SwiftUI
import Photos

struct HomeScreenCard: View {
    
    var cardTitle : String
    var lists : [PhotoAssetModel] = []
    
    var body: some View {
        ZStack{
            VStack{
                VStack{
                    HStack{
                        VStack(alignment: .leading){
                            Text(cardTitle)
                                .foregroundStyle(Color.grey100)
                                .font(.system(size: 20))
                            Text("\(lists.count) Photos")
                                .foregroundStyle(.gray)
                                .font(.system(size: 14))
                        }
                        Spacer()
                    }
                    
                    // Using LazyHStack for lazy loading of images
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(lists.prefix(3), id: \.id) { item in
                                AssetImageView(asset: item.asset)
                                    .frame(width: 120, height: 120)
                                    .cornerRadius(8)
                            }
                        }
                    }
                }
                .padding(10)
                .background(Color.grey240)
                .cornerRadius(8, corners: .topLeft)
                .cornerRadius(8, corners: .topRight)
                .cornerRadius(8, corners: .bottomLeft)
            }
        }
        
    }
}

#Preview {
    VStack{
        HomeScreenCard(cardTitle: "Photos")
            
    }
        
}
