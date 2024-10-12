//
//  NSAttributedStringExtension.swift
//  PharmaVision
//
//  Created by Kunal Personl on 12/08/24.
//

import UIKit

extension NSAttributedString {
    convenience init?(html: String) {
        guard let data = html.data(using: .utf8) else {
            return nil
        }
        
        try? self.init(
            data: data,
            options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ],
            documentAttributes: nil
        )
    }
    func applyingColor(_ color: UIColor) -> NSAttributedString {
        let mutableAttrString = NSMutableAttributedString(attributedString: self)
        let range = NSRange(location: 0, length: mutableAttrString.length)
        mutableAttrString.addAttribute(.foregroundColor, value: color, range: range)
        return mutableAttrString
    }
    func applyingFont(_ font: UIFont) -> NSAttributedString {
            let mutableAttrString = NSMutableAttributedString(attributedString: self)
            let range = NSRange(location: 0, length: mutableAttrString.length)
            mutableAttrString.addAttribute(.font, value: font, range: range)
            return mutableAttrString
        }
}

// Usage
let htmlString = "<b>Bold text</b> and <i>italic text</i> with <a href=\"https://www.example.com\">a link</a>."
let attributedString = NSAttributedString(html: htmlString)
