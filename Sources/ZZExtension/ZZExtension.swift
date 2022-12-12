//
//  ZZCompatible.swift
//  ZZExtension
//
//  Created by Ethan on 2022/5/9.
//  Copyright © 2022 ZZExtension. All rights reserved.
//

import Foundation

public struct ZZ<Base> {
    public var base: Base
    init(_ base: Base) {
        self.base = base
    }
}

public protocol ZZCompatible { }

extension ZZCompatible {
    public var zz: ZZ<Self> { ZZ(self) }
    public static var zz: ZZ<Self>.Type { ZZ<Self>.self }
}

public struct ZZGeneric<Base, T> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

public protocol ZZGenericCompatible {
    associatedtype T
}

public extension ZZGenericCompatible {
    var zz: ZZGeneric<Self, T> { ZZGeneric(self) }
    static var zz: ZZGeneric<Self, T>.Type { ZZGeneric<Self, T>.self}
}
