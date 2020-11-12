//
// CRC8.swift
//
// Copyright © 2020 QuickBird Studios. All rights reserved.
//

import Foundation

/// Class to conveniently calculate CRC-8. It uses the CRC8-Bluetooth polynomial (0xA7) by default
public class CRC8: CRC {

    /// The table that stores the precomputed remainders for all possible divisions for 1 byte
    /// This table is used as a lookup (to speed up the calculation)
    public let lookupTable: [UInt8]

    private(set) public var currentValue: UInt8 = 0

    /// Creates the instance for calculating CRC
    /// - Parameter polynomial: The polynomial to use. It uses CRC8-Bluetooth's polynomial (0xA7) by default
    public init(polynomial: UInt8 = 0xA7) {
        /// Generates the lookup table (make sure to generate it only once)
        self.lookupTable = (0...255).map { Self.CRC8(for: UInt8($0), polynomial: polynomial) }
    }

    public func append(_ bytes: [UInt8]) {
        currentValue = CRC8(for: bytes, initialValue: currentValue)
    }

    public func reset() {
        currentValue = 0
    }
}

/// Same code as the blog article
extension CRC8 {
    /// Caculates CRC-8 of an array of Bytes (UInt8)
    private func CRC8(for inputs: [UInt8], initialValue: UInt8 = 0) -> UInt8 {
        inputs.reduce(initialValue) { remainder, byte in
            let index = byte ^ remainder
            return lookupTable[Int(index)]
        }
    }

    /// Calculates the CRC-8 of 1 Byte
    private static func CRC8(for input: UInt8, polynomial: UInt8) -> UInt8 {
        var result = input
        for _ in 0..<8 {
            let isMostSignificantBitOne = result & 0x80 != 0

            result = result << 1
            if isMostSignificantBitOne {
                result = result ^ polynomial
            }
        }

        return result
    }
}
