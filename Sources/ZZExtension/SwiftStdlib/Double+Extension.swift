//
//  Double+Extension.swift
//  ZZExtension
//
//  Created by Ethan on 2022/5/9.
//  Copyright © 2022 ZZExtension. All rights reserved.
//

import CoreGraphics

extension Double: ZZCompatible {}

// MARK: - Properties

public extension ZZ where Base == Double {

    /// Check if integer is positive.
    var isPositive: Bool {
        return base > 0
    }

    /// Check if integer is negative.
    var isNegative: Bool {
        return base < 0
    }
    
}

// MARK: - Methods

public extension ZZ where Base == Double {

    /// Round up float to decimal places.
    /// - Parameter places: Decimal places.
    /// - Returns: Double.
    func rounded(_ places: Int) -> Base {
        let divisor = pow(10.0, Base(places))
        return (base * divisor).rounded() / divisor
    }

}
