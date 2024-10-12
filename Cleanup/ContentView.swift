//
//  ContentView.swift
//  Cleanup
//
//  Created by Kunal Personl on 26/09/24.
//

import SwiftUI
import SwiftfulRouting

struct ContentView: View {
    var body: some View {
        RouterView(addNavigationView: true) { router in
            HomeScreen()
        }
    }
}

#Preview {
    ContentView()
}
