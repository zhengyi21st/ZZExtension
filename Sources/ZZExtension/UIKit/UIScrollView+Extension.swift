//
//  UIScrollView+Extension.swift
//  ZZExtension
//
//  Created by Ethan on 2022/5/13.
//  Copyright © 2022 ZZExtension. All rights reserved.
//

import UIKit

// MARK: - Properties

public extension ZZ where Base: UIScrollView {

}

// MARK: - Methods

public extension ZZ where Base: UIScrollView {

    /// Stop scrolling immediately.
    func killScroll() {

        let offset: CGPoint =  base.contentOffset
        let showsVerticalScrollIndicator = base.showsVerticalScrollIndicator
        let showsHorizontalScrollIndicator = base.showsHorizontalScrollIndicator
        base.showsVerticalScrollIndicator = false
        base.setContentOffset(offset, animated: false)
        base.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        base.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
    }

    /// Takes a snapshot of an entire ScrollView.
    /// - Returns: Snapshot as UIImage for rendered ScrollView.
    func snapshot() -> UIImage? {
        // Original Source: https://gist.github.com/thestoics/1204051
        UIGraphicsBeginImageContextWithOptions(base.contentSize, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        let previousFrame = base.frame
        base.frame = CGRect(origin: base.frame.origin, size: base.contentSize)
        base.layer.render(in: context)
        base.frame = previousFrame
        return UIGraphicsGetImageFromCurrentImageContext()
    }

}
