//
// CRC.swift
//
// Copyright © 2020 QuickBird Studios. All rights reserved.
//

/// A cyclic redundancy check (CRC) parameterized by polynomial, initial value,
/// bit reflection, and output XOR mask.
///
/// `Value` selects the CRC width — use `UInt8` for CRC-8, `UInt16` for CRC-16,
/// `UInt32` for CRC-32, `UInt64` for CRC-64 (or the `CRC8`/`CRC16`/`CRC32`/`CRC64`
/// typealiases). Pre-built standard variants are provided as static members
/// on each typealias, e.g. ``CRC16/modbus`` and ``CRC32/bzip2``.
///
/// A 256-entry lookup table is computed once in ``init(polynomial:initialValue:reflected:xorOut:)``
/// and reused for every subsequent ``calculate(for:)``, so reusing the same
/// `CRC` instance across many payloads is cheap.
public struct CRC<Value: FixedWidthInteger>: Checksum {

    // MARK: Stored Properties

    /// The starting register value used by ``calculate(for:)``.
    ///
    /// Stored already bit-reversed when ``reflected`` is `true`, so that
    /// ``calculate(for:in:)`` can use it as-is without re-reflecting on every call.
    public let initialValue: Value

    /// Whether input bytes and the polynomial are processed with reflected
    /// (LSB-first) bit order.
    ///
    /// Many CRC variants are defined this way (Modbus, USB, the standard CRC-32,
    /// …). When `true`, both the polynomial and ``initialValue`` are reflected
    /// internally; callers still pass the polynomial in its conventional
    /// non-reflected form to ``init(polynomial:initialValue:reflected:xorOut:)``.
    public let reflected: Bool

    /// Mask XOR-ed into the running register by ``complete(_:)`` to produce
    /// the final CRC value.
    public let xorOut: Value

    /// The 256-entry byte-wise lookup table derived from `polynomial`.
    ///
    /// Exposed primarily so it can be inspected in tests; the table is an
    /// implementation detail and most users should never need to read it.
    public let lookupTable: [Value]

    // MARK: Initialization

    /// Creates a CRC with the given parameters and precomputes its lookup table.
    ///
    /// - Parameters:
    ///   - polynomial: The generator polynomial in its conventional (non-reflected)
    ///     big-endian form. For example, CRC-16/CCITT uses `0x1021`.
    ///   - initialValue: The register value to start with. Defaults to `0`.
    ///   - reflected: When `true`, the algorithm processes bytes LSB-first and
    ///     internally reflects both the polynomial and `initialValue`. Defaults
    ///     to `false`.
    ///   - xorOut: A value XOR-ed into the result by ``complete(_:)`` to produce
    ///     the final CRC. Defaults to `0`.
    public init(
        polynomial: Value,
        initialValue: Value = 0,
        reflected: Bool = false,
        xorOut: Value = 0
    ) {
        self.initialValue = reflected ? initialValue.reversed : initialValue
        self.reflected = reflected
        self.xorOut = xorOut

        let indices = UInt8.min...UInt8.max
        self.lookupTable = [Value](unsafeUninitializedCapacity: indices.count) { pointer, initializedCapacity in
            var result: Value = 0
            if reflected {
                let reversedPolynomial = polynomial.reversed
                for index in indices {
                    result = Value(index).littleEndian
                    for _ in 0..<UInt8.bitWidth {
                        result = (result & 0x1 != 0)
                            ? (result >> 1) ^ reversedPolynomial
                            : (result >> 1)
                    }
                    pointer[Int(index)] = result
                }
            } else {
                let mostSignificantBitOne: Value = (1 << (Value.bitWidth - 1))
                for index in indices {
                    result = Value(index).bigEndian
                    for _ in 0..<UInt8.bitWidth {
                        result = (result & mostSignificantBitOne != 0)
                            ? (result << 1) ^ polynomial
                            : (result << 1)
                    }
                    pointer[Int(index)] = result
                }
            }

            initializedCapacity = indices.count
        }
    }

    // MARK: Methods

    /// Mixes the given bytes into an in-progress CRC register.
    ///
    /// This is the streaming primitive that ``CRCCalculator`` is built on top
    /// of. It does *not* apply ``xorOut`` — call ``complete(_:)`` once after
    /// the last chunk to finalize the result.
    ///
    /// - Parameters:
    ///   - bytes: A sequence of bytes to mix into `value`.
    ///   - value: The running register. Initialize it with ``initialValue``
    ///     before the first call.
    public func calculate<S: Sequence<UInt8>>(for bytes: S, in value: inout Value) {
        if reflected {
            for byte in bytes {
                let input = Value(byte).littleEndian
                let index = (input ^ value) & 0xFF
                value = lookupTable[Int(index)] ^ (value >> 8)
            }
        } else {
            let bitWidthOverByteWidth = Value.bitWidth - 8
            for byte in bytes {
                let input = Value(byte).bigEndian
                let index = (input ^ value) >> bitWidthOverByteWidth
                value = lookupTable[Int(index)] ^ (value << 8)
            }
        }
    }

    /// Applies ``xorOut`` to `value`, producing the final CRC.
    ///
    /// Call this once after the last ``calculate(for:in:)`` chunk.
    public func complete(_ value: inout Value) {
        value ^= xorOut
    }

    /// Computes the CRC of the given bytes in one shot.
    ///
    /// Equivalent to seeding a register with ``initialValue``, calling
    /// ``calculate(for:in:)``, and then ``complete(_:)``.
    public func calculate<S: Sequence<UInt8>>(for bytes: S) -> Value {
        var value = initialValue
        calculate(for: bytes, in: &value)
        complete(&value)
        return value
    }

}

extension CRC: Sendable where Value: Sendable {}

extension FixedWidthInteger {

    internal var reversed: Self {
        let bitWidth = bitWidth
        var result: Self = 0

        for bitIndex in 0..<bitWidth {
            if self & (1 << bitIndex) != 0 {
                result |= (1 << (bitWidth - 1 - bitIndex))
            }
        }

        return result
    }

}
