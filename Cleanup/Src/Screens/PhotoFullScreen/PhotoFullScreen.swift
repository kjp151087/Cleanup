import SwiftUI
import Photos

struct PhotoFullScreen: View {
    
    @StateObject var vm: PhotoFullScreenViewModel
    
    init(currentIndex: Int, assetList : [PhotoAssetModel]? = nil, title : String? = nil) {
        _vm = StateObject(wrappedValue: PhotoFullScreenViewModel(index: currentIndex, assetList: assetList, title: title))
    }
    
    var body: some View {
        ZStack {
            VStack{
                HeaderView(title: vm.title ?? "")
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
