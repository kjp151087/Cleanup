//
//  BadgeCountButton.swift
//  PharmaVision
//
//  Created by Kunal Personl on 10/08/24.
//

import SwiftUI

struct BadgeCountButton: View {
    
    var action: () -> Void
    var icon : Image
    var count = 0
    var width = 35.0
    var height = 35.0
    var badgeSide = Edge.Set.trailing
    
    var body: some View {
        Button(action:action, label: {
            VStack(spacing:0){
                ZStack{
                    VStack{
                        icon
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: width-10,height: height-10)
                            
                    }
                    .offset(x: -2,y:2)
                    if count > 0 {
                            VStack{
                                VStack{
                                    Text("\(count)")
                                        .font(.system(size: 9))
                                        .foregroundColor(.white)
                                        .padding(.horizontal,4)
                                        .padding(.vertical,2)
                                        .frame(minWidth: 15,minHeight: 10)
                                    
                                }
                                .background(Color.red)
                                .cornerRadius(10)
                                .frame(minWidth: 20,minHeight: 20)
                            }
                            .offset(x: badgeSide == Edge.Set.trailing ? 8 : -8,y:-8)
                    }
                }
                
            }
            .frame(width: width-6,height: height-6)
            .padding(0)
        })
    }
    
}


struct BadgeCountButton_Previews: PreviewProvider {
    static var previews: some View {
        BadgeCountButton(action: {
            
        }, icon: Image("like-empty"),count: 3,badgeSide: Edge.Set.trailing)
            .previewLayout(.sizeThatFits)
            
    }
}
