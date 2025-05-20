//
//  HomeScreen.swift
//  Cleanup
//
//  Created by Kunal Personl on 26/09/24.
//

import SwiftUI

struct HomeScreen: View {
    
    @StateObject var vm = HomeScreenViewModel()
    @Environment(\.router) var router
    @EnvironmentObject var photoManager: PhotoKitManager


    var body: some View {
        VStack {
            ScrollView{
                
                VStack {
                    if vm.chartData.count > 0 {
                        DonutChartView(info: vm.chartData,
                                       innerText: "")
                        .frame(height: 200)
                    }
                }
                
                Button{
                    router.showScreen(.push) { r in
                        SimilarPhotoScreen()
                    }
                }label: {
                    Text("Show Similar Photos")
                }
                
                if (photoManager.isScaning) {
                    ProgressView("Scaning Photos/Videos(\(String(format: "%0.2f", vm.progress * 100)))", value: vm.progress, total: 1.0)
                        .padding()
                }
                
                VStack{
                    Button {
                        router.showScreen(.push) { r in
                            PhotoScreen(assetList: vm.photos)
                        }
                    } label: {
                        HomeScreenCard(cardTitle: "Photos",lists: vm.photos)
                    }

                    HomeScreenCard(cardTitle: "Videos",lists: vm.videos)
                    HomeScreenCard(cardTitle: "Live Photos",lists: vm.livePhotos)
                    HomeScreenCard(cardTitle: "Screen Shots",lists: vm.screenshots)
                    
                    
                    Button {
                        router.showScreen(.push) { r in
                            PhotoScreen(assetList: vm.deletedPhotos)
                        }
                    } label: {
                        HomeScreenCard(cardTitle: "Deleted Photos",lists: vm.deletedPhotos)
                    }
                }
            }
        }
        .onAppear(perform: {
            if (PhotoKitManager.shared.isAccessGranted){
                vm.deletedPhotos = PhotoKitManager.shared.deletedPhotoList
                
                Utility.performAsync(delay: 2) {
                    router.showScreen(.push) { r in
                        SimilarPhotoScreen()
                    }
                }
            }
        })
        .onLoad {
            vm.requestPermission()
        }
    }
    
}

#Preview {
    HomeScreen()
}
