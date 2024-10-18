import SwiftUI

struct PhotoScreen: View {
    
    @StateObject var vm = PhotoScreenViewModel()
    @Environment(\.router) var router

    // Define the grid layout with flexible columns
    let columns = [
        GridItem(.flexible(), spacing: 10), // Horizontal spacing between columns
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) { // Vertical spacing between rows
                        ForEach(vm.photos.indices, id: \.self) { index in
                            let asset = vm.photos[index]

                            Button {
                                router.showScreen(.push) { router in
                                    PhotoFullScreen(currentIndex: index)
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
//                vm.loadPhotos() // Trigger loading photos
            }
        }
    }
}

#Preview {
    PhotoScreen()
}
