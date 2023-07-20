//
// CRC16.swift
//
// Copyright © 2020 QuickBird Studios. All rights reserved.
//

import Foundation

public typealias CRC16 = CRC<UInt16>

extension CRC16 {

    public static let a = Self(polynomial: 0x1021, initialValue: 0xC6C6, reflected: true)
    public static let arc = Self(polynomial: 0x8005, reflected: true)
    public static let aug_ccitt = Self(polynomial: 0x1021, initialValue: 0x1D0F)
    public static let buyPass = Self(polynomial: 0x8005)
    public static let ccitt_false = Self(polynomial: 0x1021, initialValue: 0xFFFF)
    public static let cdma2000 = Self(polynomial: 0xC867, initialValue: 0xFFFF)
    public static let dds110 = Self(polynomial: 0x8005, initialValue: 0x800D)
    public static let dectR = Self(polynomial: 0x0589, xorOut: 0x0001)
    public static let dectX = Self(polynomial: 0x0589)
    public static let dnp = Self(polynomial: 0x3D65, reflected: true, xorOut: 0xFFFF)
    public static let en13757 = Self(polynomial: 0x3D65, xorOut: 0xFFFF)
    public static let genibus = Self(polynomial: 0x1021, initialValue: 0xFFFF, xorOut: 0xFFFF)
    public static let kermit = Self(polynomial: 0x1021, reflected: true)
    public static let maxim = Self(polynomial: 0x8005, reflected: true, xorOut: 0xFFFF)
    public static let mcrf4xx = Self(polynomial: 0x1021, initialValue: 0xFFFF, reflected: true)
    public static let modbus = Self(polynomial: 0x8005, initialValue: 0xFFFF, reflected: true)
    public static let riello = Self(polynomial: 0x1021, initialValue: 0xB2AA, reflected: true)
    public static let t10_dif = Self(polynomial: 0x8BB7)
    public static let teledisk = Self(polynomial: 0xA097)
    public static let tms37157 = Self(polynomial: 0x1021, initialValue: 0x89EC, reflected: true)
    public static let usb = Self(polynomial: 0x8005, initialValue: 0xFFFF, reflected: true, xorOut: 0xFFFF)
    public static let x25 = Self(polynomial: 0x1021, initialValue: 0xFFFF, reflected: true, xorOut: 0xFFFF)
    public static let xmodem = Self(polynomial: 0x1021)

}
