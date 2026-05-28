//
// CRC32.swift
//
// Copyright © 2020 QuickBird Studios. All rights reserved.
//

/// A 32-bit CRC. See ``CRC`` for the underlying algorithm.
public typealias CRC32 = CRC<UInt32>

extension CRC32 {

    /// CRC-32 / IEEE 802.3 (Ethernet, gzip, PNG, ZIP). The most common CRC-32.
    public static let `default` = Self(polynomial: 0x04C11DB7, initialValue: 0xFFFFFFFF, reflected: true, xorOut: 0xFFFFFFFF)

    /// CRC-32/BZIP2 — the non-reflected form of the IEEE polynomial used by bzip2.
    public static let bzip2 = Self(polynomial: 0x04C11DB7, initialValue: 0xFFFFFFFF, xorOut: 0xFFFFFFFF)

    /// JAMCRC — IEEE polynomial without the final XOR.
    public static let jamCRC = Self(polynomial: 0x04C11DB7, initialValue: 0xFFFFFFFF, reflected: true)

    /// CRC-32/MPEG-2 (MPEG-2 transport stream).
    public static let mpeg2 = Self(polynomial: 0x04C11DB7, initialValue: 0xFFFFFFFF)

    /// CRC-32/POSIX (a.k.a. CRC-32/CKSUM — the BSD `cksum` utility).
    public static let posix = Self(polynomial: 0x04C11DB7, xorOut: 0xFFFFFFFF)

    /// CRC-32/SATA.
    public static let sata = Self(polynomial: 0x04C11DB7, initialValue: 0x52325032)

    /// CRC-32/XFER — used in XFER framing.
    public static let xfer = Self(polynomial: 0x000000AF)

    /// CRC-32C (Castagnoli) — used by iSCSI, SCTP, ext4, Btrfs, and hardware-accelerated on x86 SSE 4.2.
    public static let c = Self(polynomial: 0x1EDC6F41, initialValue: 0xFFFFFFFF, reflected: true, xorOut: 0xFFFFFFFF)

    /// CRC-32D.
    public static let d = Self(polynomial: 0xA833982B, initialValue: 0xFFFFFFFF, reflected: true, xorOut: 0xFFFFFFFF)

    /// CRC-32Q (aviation — AIXM).
    public static let q = Self(polynomial: 0x814141AB)

}
