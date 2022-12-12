//
//  UIFont+Extension.swift
//  ZZExtension
//
//  Created by Ethan on 2022/5/13.
//  Copyright © 2022 ZZExtension. All rights reserved.
//

import UIKit

extension UIFont: ZZCompatible { }

// MARK: - Properties

public extension ZZ where Base: UIFont {
    
}

// MARK: - Methods

public extension ZZ where Base: UIFont {
    
    static func height(font: UIFont) -> CGFloat {
        let label = UILabel()
        label.font = font
        label.text = "Lorem Ipsum"
        label.sizeToFit()
        return label.bounds.height
    }
    
    static func textSize(font: UIFont, text: String, width: CGFloat = .greatestFiniteMagnitude, height: CGFloat = .greatestFiniteMagnitude, numberOfLines: Int = 0) -> CGSize {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height))
        label.numberOfLines = 0
        label.font = font
        label.text = text
        label.numberOfLines = numberOfLines
        label.sizeToFit()
        return label.frame.size
    }
    
    static func preferredFont(forTextStyle style: UIFont.TextStyle, weight: UIFont.Weight = .regular, italic: Bool = false) -> UIFont {
        // Get the style's default pointSize
        let traits = UITraitCollection(preferredContentSizeCategory: .large)
        let desc = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style, compatibleWith: traits)
        // Get the font at the default size and preferred weight
        var font = UIFont.systemFont(ofSize: desc.pointSize, weight: weight)
        if italic == true {
            font = font.zz.with([.traitItalic])
        }
        // Setup the font to be auto-scalable
        let metrics = UIFontMetrics(forTextStyle: style)
        return metrics.scaledFont(for: font)
    }
    
    private func with(_ traits: UIFontDescriptor.SymbolicTraits...) -> UIFont {
        guard let descriptor = base.fontDescriptor.withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits).union(base.fontDescriptor.symbolicTraits)) else {
            return base
        }
        return UIFont(descriptor: descriptor, size: 0)
    }
}
