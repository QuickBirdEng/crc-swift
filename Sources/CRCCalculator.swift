//
// CRCCalculator.swift
//
// Copyright © 2023 QuickBird Studios. All rights reserved.
//

/// `CRCCalculator` specialized for 8-bit CRCs.
public typealias CRC8Calculator = CRCCalculator<UInt8>

/// `CRCCalculator` specialized for 16-bit CRCs.
public typealias CRC16Calculator = CRCCalculator<UInt16>

/// `CRCCalculator` specialized for 32-bit CRCs.
public typealias CRC32Calculator = CRCCalculator<UInt32>

/// `CRCCalculator` specialized for 64-bit CRCs.
public typealias CRC64Calculator = CRCCalculator<UInt64>

/// An incremental, streaming CRC computation.
///
/// Use a `CRCCalculator` when the payload arrives in chunks and you want to
/// avoid buffering it. Feed chunks with ``append(_:)-`` (or one of the
/// `append(bigEndian:)` overloads), then read ``finalValue`` to obtain the
/// finalized CRC.
///
/// `CRCCalculator` is a value type: copying it snapshots the current progress,
/// which is useful when you need to compute a CRC over a prefix of a stream
/// without consuming the rest.
public struct CRCCalculator<Value: FixedWidthInteger & Sendable> {

    // MARK: Stored Properties

    /// The CRC configuration this calculator is computing against.
    public private(set) var crc: CRC<Value>

    /// The in-progress CRC register, before ``CRC/xorOut`` is applied.
    ///
    /// This is the running state the calculator threads through each
    /// ``append(_:)-`` call. For the finalized CRC, read ``finalValue``.
    public private(set) var currentValue: Value

    // MARK: Computed Properties

    /// The finalized CRC, with ``CRC/xorOut`` applied.
    ///
    /// Reading this property does not mutate the calculator, so it's safe to
    /// observe the result at any point and keep appending more bytes
    /// afterwards.
    public var finalValue: Value {
        var finalValue = currentValue
        crc.complete(&finalValue)
        return finalValue
    }

    // MARK: Initialization

    /// Creates a calculator seeded with `crc`'s ``CRC/initialValue``.
    public init(_ crc: CRC<Value>) {
        self.crc = crc
        self.currentValue = crc.initialValue
    }

    // MARK: Methods

    /// Mixes the given bytes into the running CRC.
    public mutating func append<S: Sequence<UInt8>>(_ bytes: S) {
        crc.calculate(for: bytes, in: &currentValue)
    }

    /// Resets the running CRC back to the initial value, optionally switching
    /// to a different CRC configuration.
    ///
    /// - Parameter newCRC: If non-`nil`, the calculator adopts this CRC
    ///   configuration. If `nil` (the default), the existing configuration is
    ///   kept and only ``currentValue`` is reset.
    public mutating func reset(switchingTo newCRC: CRC<Value>? = nil) {
        if let newCRC { crc = newCRC }
        currentValue = crc.initialValue
    }

}

extension CRCCalculator {

    /// Variadic convenience for appending a small, literal byte sequence.
    public mutating func append(_ bytes: UInt8...) {
        append(bytes)
    }

    /// Appends `value` serialized in big-endian (network) byte order.
    public mutating func append<T: FixedWidthInteger>(bigEndian value: T) {
        withUnsafeBytes(of: value.bigEndian) { append($0) }
    }

    /// Appends `value` serialized in big-endian byte order.
    ///
    /// Only available on arm64 platforms (and not on x86_64 macOS) because
    /// Swift's `Float16` itself is restricted to arm64 there.
    #if arch(arm64)
    @available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *)
    public mutating func append(bigEndian value: Float16) {
        append(bigEndian: value.bitPattern)
    }
    #endif

    /// Appends `value` serialized in big-endian byte order.
    public mutating func append(bigEndian value: Float32) {
        append(bigEndian: value.bitPattern)
    }

    /// Appends `value` serialized in big-endian byte order.
    public mutating func append(bigEndian value: Float64) {
        append(bigEndian: value.bitPattern)
    }

}

extension CRCCalculator: Sendable {}
