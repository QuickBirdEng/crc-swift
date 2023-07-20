//
// CRC32.swift
//
// Copyright © 2020 QuickBird Studios. All rights reserved.
//

import Foundation

public typealias CRC32 = CRC<UInt32>

extension CRC32 {

    public static let `default` = Self(polynomial: 0x04C11DB7, initialValue: 0xFFFFFFFF, reflected: true, xorOut: 0xFFFFFFFF)
    public static let bzip2 = Self(polynomial: 0x04C11DB7, initialValue: 0xFFFFFFFF, xorOut: 0xFFFFFFFF)
    public static let jamCRC = Self(polynomial: 0x04C11DB7, initialValue: 0xFFFFFFFF, reflected: true)
    public static let mpeg2 = Self(polynomial: 0x04C11DB7, initialValue: 0xFFFFFFFF)
    public static let posix = Self(polynomial: 0x04C11DB7, xorOut: 0xFFFFFFFF)
    public static let sata = Self(polynomial: 0x04C11DB7, initialValue: 0x52325032)
    public static let xfer = Self(polynomial: 0x000000AF)

    public static let c = Self(polynomial: 0x1EDC6F41, initialValue: 0xFFFFFFFF, reflected: true, xorOut: 0xFFFFFFFF)
    public static let d = Self(polynomial: 0xA833982B, initialValue: 0xFFFFFFFF, reflected: true, xorOut: 0xFFFFFFFF)
    public static let q = Self(polynomial: 0x814141AB)

}
