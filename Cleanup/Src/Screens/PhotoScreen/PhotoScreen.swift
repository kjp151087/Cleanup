import SwiftUI
import Photos


struct PhotoScreen: View {
    
    @StateObject var vm: PhotoScreenViewModel
    @Environment(\.router) var router
    
    init(assetList : [PhotoAssetModel]? = nil)  {
        _vm = StateObject(wrappedValue: PhotoScreenViewModel(assetList: assetList ?? []))
    }

    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    var body: some View {
        VStack{
            GeometryReader { geometry in
                VStack {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 10) { // Vertical spacing between rows
                            ForEach(vm.photos.indices, id: \.self) { index in
                                let asset = vm.photos[index].asset
                                
                                Button {
                                    router.showScreen(.push) { router in
                                        PhotoFullScreen(currentIndex: index, assetList: vm.photos)
                                    }
                                } label: {
                                    AssetImageView(asset: asset,shouldReleaseOnDisapper: true)
                                        .frame(width: (geometry.size.width - 40) / 3, height: (geometry.size.width - 40) / 3)
                                        .cornerRadius(8)
                                }
                            }
                        }
                        .padding([.horizontal, .top], 10) // Padding around the grid
                    }
                }
                .onAppear {
                    
                }
            }
        }
    }
}

#Preview {
    PhotoScreen()
}
