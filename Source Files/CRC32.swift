//
// CRC32.swift
//
// Copyright © 2020 QuickBird Studios. All rights reserved.
//

import Foundation

/// Class to conveniently calculate CRC-32 It uses the CRC32 polynomial (0x04C11DB7) by default
public class CRC32: CRC {

    /// The table that stores the precomputed remainders for all possible divisions for 1 byte
    /// This table is used as a lookup (to speed up the calculation)
    public let lookupTable: [UInt32]

    private(set) public var currentValue: UInt32 = 0

    /// Creates the instance for calculating CRC
    /// - Parameter polynomial: The polynomial to use. It uses CRC32's polynomial (0x04C11DB7) by default
    public init(polynomial: UInt32 = 0x04C11DB7) {
        /// Generates the lookup table (make sure to generate it only once)
        self.lookupTable = (0...255).map { Self.crc32(for: UInt8($0), polynomial: polynomial) }
    }

    public func append(_ bytes: [UInt8]) {
        currentValue = crc32(for: bytes, initialValue: currentValue)
    }

    public func reset() {
        currentValue = 0
    }
}

extension CRC32 {
    /// Caculates CRC-32 of an array of Bytes (UInt8)
    private func crc32(for inputs: [UInt8], initialValue: UInt32 = 0) -> UInt32 {
        inputs.reduce(initialValue) { remainder, byte in
            let bigEndianInput = UInt32(byte).bigEndian
            let index = (bigEndianInput ^ remainder) >> 24
            return lookupTable[Int(index)] ^ (remainder << 8)
        }
    }

    /// Calculates the CRC-32 of 1 Byte
    private static func crc32(for input: UInt8, polynomial: UInt32) -> UInt32 {
        var result = UInt32(input).bigEndian
        for _ in 0..<8 {
            let isMostSignificantBitOne = result & 0x80000000 != 0

            result = result << 1

            if isMostSignificantBitOne {
                result = result ^ polynomial
            }
        }

        return result
    }
}
