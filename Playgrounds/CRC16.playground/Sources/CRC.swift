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

extension FixedWidthInteger {
    public var bigEndianBytes: [UInt8] {
        [UInt8](withUnsafeBytes(of: self.bigEndian) { Data($0) })
    }
}

// Please keep in mind that Float has different representations and you need to make sure
// you are using the same representation as the system you are communicating with
extension BinaryFloatingPoint {
    public var bigEndianBytes: [UInt8] {
        [UInt8](withUnsafeBytes(of: self) { Data($0) }).reversed()
    }
}
