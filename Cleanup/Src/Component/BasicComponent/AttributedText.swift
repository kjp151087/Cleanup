//
//  AttributedText.swift
//  PharmaVision
//
//  Created by Kunal Personl on 12/08/24.
//

import SwiftUI
import UIKit

struct AttributedText: UIViewRepresentable {
    let attributedString: NSAttributedString

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = false // Make the text view non-editable
        textView.isScrollEnabled = false // Disable scrolling to let SwiftUI handle it
        textView.backgroundColor = .clear // Set background to clear to match SwiftUI's background
        textView.textContainerInset = .zero // Ensure no padding within the text view
        textView.textContainer.lineFragmentPadding = 0 // Remove additional padding
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.attributedText = attributedString
        uiView.textContainerInset = .zero // Ensure no padding within the text view
        uiView.textContainer.lineFragmentPadding = 0 // Remove additional padding
    }
}


#Preview {
    AttributedText(attributedString: attributedString!)
}
