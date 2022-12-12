//
//  Array+Extension.swift
//  ZZExtension
//
//  Created by Ethan on 2022/5/9.
//  Copyright © 2022 ZZExtension. All rights reserved.
//

import Foundation

extension Array: ZZCompatible {}

// MARK: - Properties

public extension ZZ where Base: ExpressibleByArrayLiteral & Sequence & Collection {

    /// Get a random element from the array.
    var sample: Base.Element? {
        guard base.count > 0, let randomIndex = Int(arc4random_uniform(UInt32(base.count))) as? Base.Index else { return nil }
        return base[randomIndex]
    }

}

// MARK: - Methods

public extension ZZ where Base: ExpressibleByArrayLiteral & Sequence & Collection {

    /// Get random elements from the array.
    /// - Parameters:
    ///   - size: Number of elements.
    ///   - noRepeat: Whether to disable repeat, default is false.
    /// - Returns: Elements instance.
    func sample(size: Int, noRepeat: Bool = false) -> [Base.Element]? {
        guard !base.isEmpty else { return nil }
        var sampleElements: [Base.Element] = []
        if !noRepeat {
            for _ in 0..<size {
                sampleElements.append(sample!)
            }
        } else {
            var copy = base.map { $0 }
            for _ in 0..<size {
                if copy.isEmpty { break }
                let randomIndex = Int(arc4random_uniform(UInt32(copy.count)))
                let element = copy[randomIndex]
                sampleElements.append(element)
                copy.remove(at: randomIndex)
            }
        }
        return sampleElements
    }
    
    ///  - Based on:  https://stackoverflow.com/a/57209964
    func limit(_ max: Int) -> [Base.Element] {
        return base.enumerated()
            .filter { $0.offset < max }
            .map { $0.element }
    }

}
