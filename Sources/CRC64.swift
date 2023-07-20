//
// CRC64.swift
//
// Copyright © 2020 QuickBird Studios. All rights reserved.
//

import Foundation

public typealias CRC64 = CRC<UInt64>

extension CRC64 {

    public static let ecma = Self(polynomial: 0x42F0E1EBA9EA3693, initialValue: 0xFFFFFFFFFFFFFFFF, refIn: true, refOut: true, xorOut: 0xFFFFFFFFFFFFFFFF)
    public static let iso = Self(polynomial: 0x000000000000001B, initialValue: 0xFFFFFFFFFFFFFFFF, refIn: true, refOut: true, xorOut: 0xFFFFFFFFFFFFFFFF)

}
