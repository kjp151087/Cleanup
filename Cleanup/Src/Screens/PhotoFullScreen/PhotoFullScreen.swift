import SwiftUI
import Photos

struct PhotoFullScreen: View {
    
    @StateObject var vm: PhotoFullScreenViewModel
    
    init(currentIndex: Int, assetList : [PhotoAssetModel]? = nil) {
        _vm = StateObject(wrappedValue: PhotoFullScreenViewModel(index: currentIndex, assetList: assetList))
    }
    
    var body: some View {
        ZStack {
            VStack{
                HeaderView(title: "Photos")
                SwipCardContainer(photos: vm.photos, currentIndex: vm.index)
            }
        }
        .navigationBarBackButtonHidden()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onLoad {
            
        }
    }
}

#Preview {
    PhotoFullScreen(currentIndex: 0, assetList: nil)
}
