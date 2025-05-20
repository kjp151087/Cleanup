//
//  TextButton.swift
//  PharmaVision
//
//  Created by Kunal Personl on 17/08/24.
//

import SwiftUI

struct TextButton: View {
    var action: () -> Void
    @State var text : String
    @Binding var isEnable : Bool
    var padding : EdgeInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
    var textColor : Color = .black
    var backgroundColor : Color = .white
    
    
    
    var body: some View {
        Button(action: {
            if (isEnable){
                action()
            }
        }, label: {
            VStack(spacing:0){
                Text(text)
                    .padding(padding)
                    .foregroundStyle(textColor)
                    .background(backgroundColor.opacity(isEnable ? 1 : 0.5))
                    
            }
        })
    }
    
}

struct TextButton_Previews: PreviewProvider {
    static var previews: some View {
        TextButton(action: {
            
        }, text: "Login", isEnable: .constant(false))
            .previewLayout(.sizeThatFits)
    }
}
