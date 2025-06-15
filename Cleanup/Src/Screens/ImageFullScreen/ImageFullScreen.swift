//
//  ImageFullScreen.swift
//  Cleanup
//
//  Created by Kunal Personl on 15/06/25.
//

import SwiftUI

struct ImageFullScreen : View {
    let image : UIImage
    
    var body : some View {
        VStack{
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .background(.red)
        }
        .background(.yellow)
    }
}

#Preview {
    ImageFullScreen(image: UIImage(named: "test")!)
}
