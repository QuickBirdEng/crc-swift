//
// CRC64.swift
//
// Copyright © 2020 QuickBird Studios. All rights reserved.
//

/// A 64-bit CRC. See ``CRC`` for the underlying algorithm.
public typealias CRC64 = CRC<UInt64>

extension CRC64 {

    /// CRC-64/ECMA-182 (DLT-1 tape format, XZ archives).
    public static let ecma = Self(polynomial: 0x42F0E1EBA9EA3693, initialValue: 0xFFFFFFFFFFFFFFFF, reflected: true, xorOut: 0xFFFFFFFFFFFFFFFF)

    /// CRC-64/ISO (HDLC, ISO 3309).
    public static let iso = Self(polynomial: 0x000000000000001B, initialValue: 0xFFFFFFFFFFFFFFFF, reflected: true, xorOut: 0xFFFFFFFFFFFFFFFF)

}
