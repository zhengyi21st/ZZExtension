//
//  UIView+Extension.swift
//  ZZExtension
//
//  Created by Ethan on 2022/5/9.
//  Copyright © 2022 ZZExtension. All rights reserved.

import UIKit

extension UIView: ZZCompatible { }

// MARK: - Properties

public extension ZZ where Base: UIView {

    /// Find the view controller responsible for a view
    ///
    /// - Note:
    ///  - Based on:  https://stackoverflow.com/a/24590678
    var parentVC: UIViewController? {
        for view in sequence(first: base.superview, next: { $0?.superview }) {
            if let responder = view?.next {
                if responder.isKind(of: UIViewController.self) {
                    return responder as? UIViewController
                }
            }
        }
        return nil
    }

    /// Find the first responder.
    ///
    /// - Note:
    ///  - Based on:  https://stackoverflow.com/a/1823360
    var firstResponder: UIView? {
        guard !base.isFirstResponder else { return base }
        for subview in base.subviews {
            if let firstResponder = subview.zz.firstResponder {
                return firstResponder
            }
        }
        return nil
    }

}

// MARK: - Methods

public extension ZZ where Base: UIView {

    /// Capture UIView to UIImage.
    ///
    /// - Note:
    ///  - Based on:  https://stackoverflow.com/a/22494886
    /// - Returns: UIImage instance.
    func snapshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(base.bounds.size, base.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        base.drawHierarchy(in: base.bounds, afterScreenUpdates: true)
        return UIGraphicsGetImageFromCurrentImageContext()
    }

    /// Set cornerRadius for any direction.
    ///
    /// - Note:
    ///  - Based on:  https://stackoverflow.com/a/41197790
    /// - Parameters:
    ///   - corners: The corners of a rectangle.
    ///   - radius: The value of radius.
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: base.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        base.layer.mask = mask
    }
    
    /// Get the target type view from super view.
    /// - Note:
    ///  - Based on:  https://stackoverflow.com/a/41920347
    /// - Parameter type: The type of view.
    /// - Returns: The target super view.
    func parentView<T: UIView>(of type: T.Type) -> T? {
        guard let view = base.superview else {
            return nil
        }
        return (view as? T) ?? view.zz.parentView(of: T.self)
    }
}
