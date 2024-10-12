//
//  HomeScreen.swift
//  Cleanup
//
//  Created by Kunal Personl on 26/09/24.
//

import SwiftUI

struct HomeScreen: View {
    
    @StateObject var vm = HomeScreenViewModel()

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
                
                VStack{
                    HomeScreenCard(cardTitle: "Photos",lists: vm.photos)
                    HomeScreenCard(cardTitle: "Videos",lists: vm.videos)
                    HomeScreenCard(cardTitle: "Live Photos",lists: vm.livePhotos)
                    HomeScreenCard(cardTitle: "Screen shots",lists: vm.screenshots)
                }
            }
        }
        .padding()
        .onLoad {
            vm.requestPermission()
        }
    }
    
}

#Preview {
    HomeScreen()
}
