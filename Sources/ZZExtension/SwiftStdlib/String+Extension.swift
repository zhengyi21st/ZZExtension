//
//  String+Extension.swift
//  ZZExtension
//
//  Created by Ethan on 2022/5/9.
//  Copyright © 2022 ZZExtension. All rights reserved.
//

import UIKit

extension String: ZZCompatible {}

// MARK: - Properties

public extension ZZ where Base == String {

    // https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/SwiftStdlib/StringExtensions.swift

    /// Check if string is valid email format.
    ///
    /// - Note: Note that this property does not validate the email address against an email server. It merely attempts to determine whether its format is suitable for an email address.
    ///
    ///        "john@doe.com".zz.isValidEmail -> true
    ///
    var isValidEmail: Bool {
        let regex =
            "^(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])$"
        return base.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }

    /// Check if string is a valid schemed URL.
    ///
    ///        "https://google.com".zz.isValidSchemedUrl -> true
    ///        "google.com".zz.isValidSchemedUrl -> false
    ///
    var isValidUrl: Bool {
        return URL(string: base) != nil
    }

    /// Check if string is a valid https URL.
    ///
    ///        "https://google.com".zz.isValidHttpsUrl -> true
    ///
    var isValidSchemedUrl: Bool {
        guard let url = URL(string: base) else { return false }
        return url.scheme != nil
    }

    /// Check if string is a valid http URL.
    ///
    ///        "http://google.com".zz.isValidHttpUrl -> true
    ///
    var isValidHttpsUrl: Bool {
        guard let url = URL(string: base) else { return false }
        return url.scheme == "https"
    }

    /// Check if string is a valid file URL.
    ///
    ///        "file://Documents/file.txt".zz.isValidFileUrl -> true
    ///
    var isValidHttpUrl: Bool {
        guard let url = URL(string: base) else { return false }
        return url.scheme == "http"
    }

    /// Check if string is a valid file URL.
    ///
    ///        "file://Documents/file.txt".zz.isValidFileUrl -> true
    ///
    var isValidFileUrl: Bool {
        return URL(string: base)?.isFileURL ?? false
    }

    /// Check if string only contains digits.
    ///
    ///     "123".isDigits -> true
    ///     "1.3".isDigits -> false
    ///     "abc".isDigits -> false
    ///
    var isDigits: Bool {
        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: base))
    }

    /// String with no spaces or new lines in beginning and end.
    ///
    ///        "   hello  \n".zz.trimmed -> "hello"
    ///
    var trimmed: String {
        return base.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// Readable string from a URL string.
    ///
    ///        "it's%20easy%20to%20decode%20strings".zz.urlDecoded -> "it's easy to decode strings"
    ///
    var urlDecoded: String {
        return base.removingPercentEncoding ?? base
    }

    /// URL escaped string.
    ///
    ///        "it's easy to encode strings".zz.urlEncoded -> "it's%20easy%20to%20encode%20strings"
    ///
    var urlEncoded: String {
        return base.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? base
    }

    /// String without spaces and new lines.
    ///
    ///        "   \n Swifter   \n  Swift  ".zz.withoutSpacesAndNewLines -> "SwifterSwift"
    ///
    var withoutSpacesAndNewLines: String {
        return base.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "")
    }

}

// MARK: - Methods

public extension ZZ where Base == String {

    /// Safely subscript string with index.
    ///
    ///        "Hello World!".zz[safe: 3] -> "l"
    ///        "Hello World!".zz[safe: 20] -> nil
    ///
    /// - Parameter index: index.
    subscript(safe index: Int) -> Character? {
        guard index >= 0, index < base.count else { return nil }
        return base[base.index(base.startIndex, offsetBy: index)]
    }

    /// Safely subscript string within a given range.
    ///
    ///        "Hello World!".zz[safe: 6..<11] -> "World"
    ///        "Hello World!".zz[safe: 21..<110] -> nil
    ///
    ///        "Hello World!".zz[safe: 6...11] -> "World!"
    ///        "Hello World!".zz[safe: 21...110] -> nil
    ///
    /// - Parameter range: Range expression.
    subscript<R>(safe range: R) -> String? where R: RangeExpression, R.Bound == Int {
        let range = range.relative(to: Int.min..<Int.max)
        guard range.lowerBound >= 0,
              let lowerIndex = base.index(base.startIndex, offsetBy: range.lowerBound, limitedBy: base.endIndex),
              let upperIndex = base.index(base.startIndex, offsetBy: range.upperBound, limitedBy: base.endIndex) else {
            return nil
        }

        return String(base[lowerIndex..<upperIndex])
    }

    /// Lorem ipsum string of given length.
    ///
    /// - Parameter length: number of characters to limit lorem ipsum to (default is 445 - full lorem ipsum).
    /// - Returns: Lorem ipsum dolor sit amet... string.
    static func loremIpsum(ofLength length: Int = 445) -> String {
        guard length > 0 else { return "" }
        // https://www.lipsum.com/
        let loremIpsum = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
        """
        if loremIpsum.count > length {
            return String(loremIpsum[loremIpsum.startIndex..<loremIpsum.index(loremIpsum.startIndex, offsetBy: length)])
        }
        return loremIpsum
    }

    /// Random string of given length.
    ///
    ///        String.zz.random(ofLength: 18) -> "u7MMZYvGo9obcOcPj8"
    ///
    /// - Parameter length: number of characters in string.
    /// - Returns: random string of given length.
    static func random(ofLength length: Int) -> String {
        guard length > 0 else { return "" }
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString = ""
        for _ in 1...length {
            randomString.append(base.randomElement()!)
        }
        return randomString
    }

    /// Sliced string from a start index with length.
    ///
    ///        "Hello World".zz.slicing(from: 6, length: 5) -> "World"
    ///
    /// - Parameters:
    ///   - index: string index the slicing should start from.
    ///   - length: amount of characters to be sliced after given index.
    /// - Returns: sliced substring of length number of characters (if applicable) (example: "Hello World".slicing(from: 6, length: 5) -> "World").
    func slicing(from index: Int, length: Int) -> String? {
        guard length >= 0, index >= 0, index < base.count else { return nil }
        guard index.advanced(by: length) <= base.count else {
            return self[safe: index..<base.count]
        }
        guard length > 0 else { return "" }
        return self[safe: index..<index.advanced(by: length)]
    }

    /// Create date from string.
    /// - Parameter format: Date format (default is "dd/MM/yyyy HH:mm").
    /// - Returns: Date.
    func date(withFormat format: String = "dd/MM/yyyy HH:mm") -> Date? {
        let selfLowercased = base.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = format
        return formatter.date(from: selfLowercased)
    }
}
