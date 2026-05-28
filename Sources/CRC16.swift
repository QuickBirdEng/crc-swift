//
// CRC16.swift
//
// Copyright © 2020 QuickBird Studios. All rights reserved.
//

/// A 16-bit CRC. See ``CRC`` for the underlying algorithm.
public typealias CRC16 = CRC<UInt16>

extension CRC16 {

    /// CRC-16/A (ISO/IEC 14443-3 Type A).
    public static let a = Self(polynomial: 0x1021, initialValue: 0xC6C6, reflected: true)

    /// CRC-16/ARC (a.k.a. CRC-16/IBM, LHA, ARC archives).
    public static let arc = Self(polynomial: 0x8005, reflected: true)

    /// CRC-16/AUG-CCITT — CCITT polynomial with the alternate `0x1D0F` initial value.
    public static let aug_ccitt = Self(polynomial: 0x1021, initialValue: 0x1D0F)

    /// CRC-16/BUYPASS (a.k.a. CRC-16/UMTS / CRC-16/VERIFONE).
    public static let buyPass = Self(polynomial: 0x8005)

    /// CRC-16/CCITT-FALSE — the variant widely (mis)labelled "CCITT" in
    /// Bluetooth, SD cards, and many serial protocols.
    public static let ccitt_false = Self(polynomial: 0x1021, initialValue: 0xFFFF)

    /// CRC-16/CDMA2000.
    public static let cdma2000 = Self(polynomial: 0xC867, initialValue: 0xFFFF)

    /// CRC-16/DDS-110 (signal-generator command set).
    public static let dds110 = Self(polynomial: 0x8005, initialValue: 0x800D)

    /// CRC-16/DECT-R (DECT, "reverse" form with `xorOut = 0x0001`).
    public static let dectR = Self(polynomial: 0x0589, xorOut: 0x0001)

    /// CRC-16/DECT-X (DECT, "x" form).
    public static let dectX = Self(polynomial: 0x0589)

    /// CRC-16/DNP (Distributed Network Protocol).
    public static let dnp = Self(polynomial: 0x3D65, reflected: true, xorOut: 0xFFFF)

    /// CRC-16/EN-13757 (M-Bus metering).
    public static let en13757 = Self(polynomial: 0x3D65, xorOut: 0xFFFF)

    /// CRC-16/GENIBUS (a.k.a. CRC-16/EPC / I-CODE / DARC-16).
    public static let genibus = Self(polynomial: 0x1021, initialValue: 0xFFFF, xorOut: 0xFFFF)

    /// CRC-16/KERMIT (a.k.a. CRC-16/CCITT-TRUE, the original X.25/Kermit form).
    public static let kermit = Self(polynomial: 0x1021, reflected: true)

    /// CRC-16/MAXIM (1-Wire complement of ARC).
    public static let maxim = Self(polynomial: 0x8005, reflected: true, xorOut: 0xFFFF)

    /// CRC-16/MCRF4XX (Microchip MCRF4XX RFID).
    public static let mcrf4xx = Self(polynomial: 0x1021, initialValue: 0xFFFF, reflected: true)

    /// CRC-16/MODBUS (Modbus RTU serial framing).
    public static let modbus = Self(polynomial: 0x8005, initialValue: 0xFFFF, reflected: true)

    /// CRC-16/RIELLO (Riello UPS protocol).
    public static let riello = Self(polynomial: 0x1021, initialValue: 0xB2AA, reflected: true)

    /// CRC-16/T10-DIF (SCSI Data Integrity Field).
    public static let t10_dif = Self(polynomial: 0x8BB7)

    /// CRC-16/TELEDISK (Sydex Teledisk archive format).
    public static let teledisk = Self(polynomial: 0xA097)

    /// CRC-16/TMS37157 (Texas Instruments TMS37157 RFID).
    public static let tms37157 = Self(polynomial: 0x1021, initialValue: 0x89EC, reflected: true)

    /// CRC-16/USB (USB token packets).
    public static let usb = Self(polynomial: 0x8005, initialValue: 0xFFFF, reflected: true, xorOut: 0xFFFF)

    /// CRC-16/X-25 (HDLC, X.25 framing, IrDA).
    public static let x25 = Self(polynomial: 0x1021, initialValue: 0xFFFF, reflected: true, xorOut: 0xFFFF)

    /// CRC-16/XMODEM (XMODEM file-transfer protocol).
    public static let xmodem = Self(polynomial: 0x1021)

}
