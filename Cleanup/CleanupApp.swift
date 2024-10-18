//
//  CleanupApp.swift
//  Cleanup
//
//  Created by Kunal Personl on 26/09/24.
//

import SwiftUI

@main
struct CleanupApp: App {
    
    @StateObject var photoManager = PhotoKitManager.shared

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(photoManager)

        }
    }
}
