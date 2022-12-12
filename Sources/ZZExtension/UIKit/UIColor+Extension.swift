//
//  UIColor+Extension.swift
//  ZZExtension
//
//  Created by Ethan on 2022/5/12.
//  Copyright © 2022 ZZExtension. All rights reserved.
//

import UIKit

extension UIColor: ZZCompatible { }

// MARK: - Properties

public extension ZZ where Base: UIColor {

}

// MARK: - Methods

public extension ZZ where Base: UIColor {

    /// Create color from RGB(A).
    ///
    /// - Parameters:
    ///     - red: Red value (between 0 - 255).
    ///     - green: Green value (between 0 - 255).
    ///     - blue: Blue value (between 0 - 255).
    ///     - alpha: Blue value (between 0 - 255).
    /// - Returns: UIColor instance.
    static func rgba(red: Int, green: Int, blue: Int, alpha: CGFloat) -> UIColor {
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }

    /// Create a UIColor with different colors for light and dark mode.
    ///
    /// - Parameters:
    ///     - light: Color to use in light/unspecified mode.
    ///     - dark: Color to use in dark mode.
    /// - Returns: UIColor instance.
    static func create(light: UIColor, dark: UIColor) -> UIColor {
        if #available(iOS 13.0, tvOS 13.0, *) {
            return UIColor(dynamicProvider: { $0.userInterfaceStyle == .dark ? dark : light })
        } else {
            return UIColor(cgColor: light.cgColor)
        }
    }

    /// Create color from an hexadecimal integer value (e.g. 0xFFFFFF).
    ///
    /// - Note:
    ///  - Based on:  https://stackoverflow.com/a/48016878
    /// - Parameters:
    ///  - hex: Hexadecimal integer for color.
    /// - Returns: UIColor instance.
    static func hex(string: String) -> UIColor? {
        var cString: String = string.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        if (cString.count) != 6 {
            return UIColor.gray
        }
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}
