//
//  ViewOnLoadModifier.swift
//  AmpaCashSwiftUI
//
//  Created by Kunal Personl on 28/11/23.
//

import SwiftUI

struct ViewOnLoadModifier: ViewModifier {
    @State private var viewDidLoad = false
    let action: (() -> Void)?
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                if viewDidLoad == false {
                    viewDidLoad = true
                    action?()
                }
            }
    }
}

extension View {
    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        self.modifier(ViewOnLoadModifier(action: action))
    }
}

struct TestView : View {
    
    var body : some View {
        Text("Text")
            .onLoad {
                
            }
            
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
