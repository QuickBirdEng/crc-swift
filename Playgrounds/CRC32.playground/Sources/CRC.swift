//
// CRC.swift
//
// Copyright © 2020 QuickBird Studios. All rights reserved.
//

import Foundation

public protocol CRC {
    associatedtype Size

    var currentValue: Size { get }

    func append(_ bytes: [UInt8])

    func reset()
}

extension CRC {
    public func append(_ byte: UInt8) {
        append([byte])
    }

    public func append<T: FixedWidthInteger>(_ integer: T) {
        append(integer.bigEndianBytes)
    }

    public func append<T: BinaryFloatingPoint>(_ floatingPoint: T) {
        append(floatingPoint.bigEndianBytes)
    }
}

// MARK: - Convenience Extension Methods

extension FixedWidthInteger {
    public var bigEndianBytes: [UInt8] {
        [UInt8](withUnsafeBytes(of: self.bigEndian) { Data($0) })
    }
}

// `BinaryFloatingPoint` conforms to 754-2008 - IEEE Standard for Floating-Point Arithmetic (https://ieeexplore.ieee.org/document/4610935)
// If you target system is using a different floating point representation, you need to adapt accordingly
extension BinaryFloatingPoint {
    public var bigEndianBytes: [UInt8] {
        [UInt8](withUnsafeBytes(of: self) { Data($0) }).reversed()
    }
}
