//
//  RootAppScreen.swift
//  PharmaVision
//
//  Created by Kunal Personl on 25/08/24.
//

import SwiftUI

struct RootNavScreen<Content:View>: View {
    
    let content : Content
    @State var title : String = ""
    
    init(@ViewBuilder content : () -> Content) {
        self.content = content()
    }

    var body: some View {
        RootAppScreen{
            ZStack{
                VStack(spacing: 0){
                    content
                    Spacer()
                }
            }
        }
        .onPreferenceChange(RootNavTitlePreferenceKey.self, perform: { value in
            self.title = value
        })
        .navigationBarBackButtonHidden(true)
    }
}

extension View {
    func navTitle( _ text : String) -> some View {
        preference(key: RootNavTitlePreferenceKey.self, value: text)
    }
}


#Preview {
    RootNavScreen{
        Text("Test content")
    }
}

struct RootNavTitlePreferenceKey : PreferenceKey {
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}


