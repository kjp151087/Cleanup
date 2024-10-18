import SwiftUI

struct PhotoFullScreen: View {
    
    @StateObject var vm: PhotoFullScreenViewModel
    
    init(currentIndex: Int) {
        _vm = StateObject(wrappedValue: PhotoFullScreenViewModel(index: currentIndex))
    }
    
    /*
    var body: some View {
        ZStack {
            // Main full-screen image display
//            TabView(selection: $vm.index) { // Bind current index to the TabView
//                ForEach(vm.photos.indices, id: \.self) { index in
//                    let asset = vm.photos[index]
//                    AssetImageView(asset: asset, shouldLoadOrigin: true, shouldReleaseOnDisapper: true, indexOfList: index)
//                        .tag(index) // Tag each page with its index
//                        .padding()
//
//                }
//            }
//            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Use PageTabViewStyle for paging
//            .frame(maxWidth: .infinity, maxHeight: .infinity) // Make it full-screen
//            AssetImageView(asset: vm.getCurrentIndexAsset(),
//                           shouldLoadOrigin: true,
//                           shouldReleaseOnDisapper: true,
//                           indexOfList: vm.index)
            
            
            VStack{
                Image(uiImage: vm.currentImage ?? UIImage(named: "test")!)
                    .resizable()
                    .scaledToFit()
                    .padding()
            }
            .background(Color.gray.opacity(0.4))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack{
                Spacer()
                HStack{
                    Button {
                        
                    } label: {
                        Text("DELETE")
                    }
                    Spacer()
                    Button {
                        vm.updateToNextIndex()
                    } label: {
                        Text("KEEP")
                    }
                    
                }
                .padding()
                .frame(height: 60)
            }
            
            
            // Lazy HStack for thumbnails at the bottom
            // As of now No need to show bottom thumbnail
//            VStack {
//                Spacer() // Push the thumbnails to the bottom
//                ScrollView(.horizontal, showsIndicators: false) {
//                    LazyHStack {
//                        ForEach(vm.photos.indices, id: \.self) { index in
//                            let asset = vm.photos[index]
//                            AssetImageView(asset: asset, shouldLoadOrigin: false)
//                                .frame(width: 50, height: 50)
//                                .onTapGesture {
//                                    print("index clicked \(index)")
//                                    vm.index = index // Change the main image when a thumbnail is tapped
//                                }
//                        }
//                    }
//                    .padding()
//                }
//                .frame(height: 100) // Set a fixed height for the thumbnail bar
//            }
        }
        .onLoad {
            
        }
    }
     
     */
    
    var body: some View {
        ZStack {
            VStack{
//                Image(uiImage: vm.currentImage ?? UIImage(named: "test")!)
//                    .resizable()
//                    .scaledToFit()
//                    .padding()
            }
            .background(Color.gray.opacity(0.4))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack{
                Spacer()
                HStack{
                    Button {
                        
                    } label: {
                        Text("DELETE")
                    }
                    Spacer()
                    Button {
                        vm.updateToNextIndex()
                    } label: {
                        Text("KEEP")
                    }
                    
                }
                .padding()
                .frame(height: 60)
            }
        }
        .onLoad {
            
        }
    }
}

#Preview {
    PhotoFullScreen(currentIndex: 0)
}
