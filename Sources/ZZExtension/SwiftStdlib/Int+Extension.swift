//
//  Int+Extension.swift
//  ZZExtension
//
//  Created by Ethan on 2022/5/9.
//  Copyright © 2022 ZZExtension. All rights reserved.
//

import Foundation
import CoreGraphics

extension Int: ZZCompatible {}

// MARK: - Properties

public extension ZZ where Base == Int {

    /// Check if integer is positive.
    var isPositive: Bool {
        return base > 0
    }

    /// Check if integer is negative.
    var isNegative: Bool {
        return base < 0
    }

    /// Check if integer is even.
    var isEven: Bool {
        return (base % 2) == 0
    }

    /// Check if integer is odd.
    var isOdd: Bool {
        return (base % 2) != 0
    }
}

// MARK: - Methods

public extension ZZ where Base == Int {

}
