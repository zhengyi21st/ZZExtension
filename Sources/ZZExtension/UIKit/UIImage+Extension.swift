//
//  UIImage+Extension.swift
//  ZZExtension
//
//  Created by Ethan on 2022/5/6.
//  Copyright © 2022 ZZExtension. All rights reserved.
//

import UIKit

extension UIImage: ZZCompatible { }

// MARK: - Properties

public extension ZZ where Base: UIImage {

}

// MARK: - Methods

public extension ZZ where Base: UIImage {

    /// Create UIImage by color and size.
    /// - Parameters:
    ///   - color: UIColor.
    ///   - size: CGSize.
    /// - Returns: UIImage.
    static func color(_ color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    /// Resize UIImage by target  CGSize.
    ///
    /// - Note:
    ///  - Based on:  https://www.advancedswift.com/resize-uiimage-no-stretching-swift/
    /// - Parameter targetSize: Image size.
    /// - Returns: The resized UIImage.
    func resize(targetSize: CGSize) -> UIImage {
        // Determine the scale factor that preserves aspect ratio
        let widthRatio = targetSize.width / base.size.width
        let heightRatio = targetSize.height / base.size.height
        let scaleFactor = min(widthRatio, heightRatio)
        // Compute the new image size that preserves aspect ratio
        let scaledImageSize = CGSize(
            width: base.size.width * scaleFactor,
            height: base.size.height * scaleFactor
        )
        // Draw and return the resized UIImage
        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )
        let scaledImage = renderer.image { _ in
            base.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
        return scaledImage
    }

    /// Resize UIImage by data count.
    /// - Parameter kilobyte: The count of data.
    /// - Returns: The resized Image data.
    func resize(kilobyte: Int = 1024) -> Data? {
        if let imageData = base.jpegData(compressionQuality: 1) {
            let size = imageData.count / kilobyte
            if size > kilobyte {
                let compressionValue = CGFloat(kilobyte / size)
                return base.jpegData(compressionQuality: compressionValue)
            } else {
                return imageData
            }
        } else {
            return nil
        }
    }
}
