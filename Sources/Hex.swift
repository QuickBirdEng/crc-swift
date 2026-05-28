//
// Hex.swift
//
// Copyright © 2023 QuickBird Studios. All rights reserved.
//

extension FixedWidthInteger {

    internal var hex: String {
        withUnsafeBytes(of: bigEndian) { $0.hex }
    }

}

extension Sequence<UInt8> {

    internal var hex: String {
        self
            .map { byte -> String in
                let high = String(byte >> 4, radix: 16, uppercase: true)
                let low = String(byte & 0x0F, radix: 16, uppercase: true)
                return high + low
            }
            .joined()
    }

}
