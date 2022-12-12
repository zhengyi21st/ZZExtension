//
//  UIColor+Extension.swift
//  ZZExtension
//
//  Created by Ethan on 2022/5/9.
//  Copyright © 2022 ZZExtension. All rights reserved.
//

import UIKit

extension UIApplication: ZZCompatible { }

// MARK: - Properties

public extension ZZ where Base: UIApplication {

    /// Get the application's status bar height
    ///
    /// - Note:
    ///  - Based on:  https://stackoverflow.com/a/60475801
    static var statusBarHeight: CGFloat {
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
            return window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            return UIApplication.shared.statusBarFrame.height
        }
    }

    /// Get the application's key window
    static var keyWindow: UIWindow? {
        return UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    }
    
    static var isLandscape: Bool {
            if #available(iOS 13.0, *) {
                return UIApplication.shared.windows
                    .first?
                    .windowScene?
                    .interfaceOrientation
                    .isLandscape ?? false
            } else {
                return UIApplication.shared.statusBarOrientation.isLandscape
            }
        }
}

// MARK: - Methods

public extension ZZ where Base: UIApplication {

}
