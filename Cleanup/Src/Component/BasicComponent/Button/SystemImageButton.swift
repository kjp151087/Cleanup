//
//  SystemImageButton.swift
//  Cleanup
//
//  Created by Kunal Personl on 17/07/25.
//

import SwiftUI

struct SystemImageButton: View {
    var action: () -> Void
    var systemImageName : String
    @Binding var isEnable : Bool
    var padding : EdgeInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
    var buttonColor : Color = .black
    var backgroundColor : Color = .clear
    
    
    
    var body: some View {
        Button(action: {
            if (isEnable){
                action()
            }
        }, label: {
            VStack(spacing:0){
                Image(systemName: "play.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(buttonColor)
                    
            }
        })
    }
    
}
