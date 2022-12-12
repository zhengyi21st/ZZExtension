//
//  Date+Extension.swift
//  ZZExtension
//
//  Created by Ethan on 2022/5/9.
//  Copyright © 2022 ZZExtension. All rights reserved.
//

import Foundation

extension Date: ZZCompatible { }

// MARK: - Properties

public extension ZZ where Base == Date {

    /// Returns a Boolean value indicating whether the date is within this year.
    var isInThisYear: Bool {
        let calendar = Calendar.current
        let unit: Set<Calendar.Component> = [.year]
        let nowComps = calendar.dateComponents(unit, from: Date())
        let selfCmps = calendar.dateComponents(unit, from: base)
        return selfCmps.year == nowComps.year
    }

}

// MARK: - Methods

public extension ZZ where Base == Date {

    /// Date string from date.
    /// - Parameter format: Date format (default is "dd/MM/yyyy HH:mm").
    /// - Returns: Date string.
    func string(withFormat format: String = "dd/MM/yyyy HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: base)
    }

}
