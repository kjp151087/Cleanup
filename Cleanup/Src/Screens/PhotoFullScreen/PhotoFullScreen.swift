import SwiftUI
import Photos

struct PhotoFullScreen: View {
    
    @StateObject var vm: PhotoFullScreenViewModel
    
    init(currentIndex: Int, assetList : [PhotoAssetModel]? = nil) {
        _vm = StateObject(wrappedValue: PhotoFullScreenViewModel(index: currentIndex, assetList: assetList))
    }
    
    var body: some View {
        ZStack {
            
            /// Image view container
            VStack{
                VStack{
                    Image(uiImage: vm.currentImage ?? UIImage(named: "test")!)
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .cornerRadius(10, corners: UIRectCorner())
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .background(.blue.opacity(0.2))
                .padding(.vertical,1)
            }
            .background(.red.opacity(0.2))
            
            VStack{
                
                HStack{
                    Button {
                        PhotoKitManager.shared.deleteAsset(asset: vm.getCurrentIndexAsset())
                        vm.updateToNextIndex()
                    } label: {
                        VStack{
                            Spacer()
                            Text("  DELETE   ")
                        }
                    }
                    .frame(maxHeight: .infinity)
                    .background(.red.opacity(0.1))
                    
                    Spacer()
                    
                    Button {
                        vm.updateToNextIndex()
                    } label: {
                        VStack{
                            Spacer()
                            Text("   KEEP    ")
                        }
                    }
                    .frame(maxHeight: .infinity)
                    .background(.red.opacity(0.1))
                }
                .frame(maxHeight: .infinity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onLoad {
            
        }
    }
}

#Preview {
    PhotoFullScreen(currentIndex: 0, assetList: nil)
}
