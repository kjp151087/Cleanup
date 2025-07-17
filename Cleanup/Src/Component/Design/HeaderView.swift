//
//  HeaderView.swift
//  Cleanup
//
//  Created by Kunal Personl on 17/07/25.
//

import SwiftUI

struct HeaderView<RightContent: View>: View {
    
    @Environment(\.router) var router

    var title: String
    var isBackVisible: Bool = true
    var onBack: (() -> Void)? = nil
    var rightContent: () -> RightContent
    
    init(
        title: String,
        isBackVisible: Bool = true,
        onBack: (() -> Void)? = nil,
        @ViewBuilder rightContent: @escaping () -> RightContent = { EmptyView() }
    ) {
        self.title = title
        self.isBackVisible = isBackVisible
        self.onBack = onBack
        self.rightContent = rightContent
    }
    
    var body: some View {
        HStack {
            if isBackVisible {
                Button(action: {
                    router.dismissScreen()
                    onBack?()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black)
                        .font(.title2)
                        .padding(.leading)
                }
            } else {
                Spacer().frame(width: 44) // keeps title centered
            }
            
            Spacer()
            
            Text(title)
                .font(.headline)
                .lineLimit(1)
            
            Spacer()
            
            // Right content or placeholder
            Group {
                if isRightContentEmpty {
                    Spacer().frame(width: 44) // to balance the back button
                } else {
                    rightContent()
                        .frame(width: 44, height: 44, alignment: .center)
                }
            }
        }
        .frame(height: 44)
        .background(Color(.systemBackground))
    }
    
    private var isRightContentEmpty: Bool {
        let content = Mirror(reflecting: rightContent())
        return content.subjectType == EmptyView.self
    }
}


#Preview {
    HeaderView(title: "Testing", isBackVisible: true) 
}
