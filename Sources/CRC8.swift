//
// CRC8.swift
//
// Copyright © 2020 QuickBird Studios. All rights reserved.
//

import Foundation

public typealias CRC8 = CRC<UInt8>

extension CRC8 {

    public static let `default` = Self(polynomial: 0x07)
    public static let cdma2000 = Self(polynomial: 0x9B, initialValue: 0xFF)
    public static let darc = Self(polynomial: 0x39, reflected: true)
    public static let dvbS2 = Self(polynomial: 0xD5)
    public static let ebu = Self(polynomial: 0x1D, initialValue: 0xFF, reflected: true)
    public static let iCode = Self(polynomial: 0x1D, initialValue: 0xFD)
    public static let itu = Self(polynomial: 0x07, xorOut: 0x55)
    public static let maxim = Self(polynomial: 0x31, reflected: true)
    public static let rohc = Self(polynomial: 0x07, initialValue: 0xFF, reflected: true)
    public static let wcdma = Self(polynomial: 0x9B, reflected: true)

}
