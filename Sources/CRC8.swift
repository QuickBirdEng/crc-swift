//
// CRC8.swift
//
// Copyright © 2020 QuickBird Studios. All rights reserved.
//

/// An 8-bit CRC. See ``CRC`` for the underlying algorithm.
public typealias CRC8 = CRC<UInt8>

extension CRC8 {

    /// CRC-8 / SMBus — polynomial `0x07`, no initial value, no XOR out.
    public static let `default` = Self(polynomial: 0x07)

    /// CRC-8/CDMA2000 — polynomial `0x9B`, initial value `0xFF`.
    public static let cdma2000 = Self(polynomial: 0x9B, initialValue: 0xFF)

    /// CRC-8/DARC (Data Radio Channel) — polynomial `0x39`, reflected.
    public static let darc = Self(polynomial: 0x39, reflected: true)

    /// CRC-8/DVB-S2 — polynomial `0xD5`.
    public static let dvbS2 = Self(polynomial: 0xD5)

    /// CRC-8/EBU (a.k.a. AES) — polynomial `0x1D`, initial value `0xFF`, reflected.
    public static let ebu = Self(polynomial: 0x1D, initialValue: 0xFF, reflected: true)

    /// CRC-8/I-CODE — polynomial `0x1D`, initial value `0xFD`.
    public static let iCode = Self(polynomial: 0x1D, initialValue: 0xFD)

    /// CRC-8/ITU — polynomial `0x07`, XOR out `0x55`.
    public static let itu = Self(polynomial: 0x07, xorOut: 0x55)

    /// CRC-8/MAXIM (Dallas 1-Wire) — polynomial `0x31`, reflected.
    public static let maxim = Self(polynomial: 0x31, reflected: true)

    /// CRC-8/ROHC (Robust Header Compression) — polynomial `0x07`, initial `0xFF`, reflected.
    public static let rohc = Self(polynomial: 0x07, initialValue: 0xFF, reflected: true)

    /// CRC-8/WCDMA — polynomial `0x9B`, reflected.
    public static let wcdma = Self(polynomial: 0x9B, reflected: true)

}
