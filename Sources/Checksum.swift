//
// Checksum.swift
//
// Copyright © 2023 QuickBird Studios. All rights reserved.
//

/// A type that computes a fixed-width integer checksum from a sequence of bytes.
///
/// ``CRC`` is the only conforming type shipped with this package, but the
/// protocol exists so that the ``verify(_:for:)-`` extension applies to any
/// future checksum algorithm.
public protocol Checksum {

    /// The integer type produced by ``calculate(for:)``. Its bit width
    /// determines the width of the checksum (e.g. `UInt32` ⇒ a 32-bit checksum).
    associatedtype Value: FixedWidthInteger

    /// Computes the checksum of the given bytes in one shot.
    ///
    /// - Parameter bytes: Any sequence of bytes — `Array<UInt8>`, `Data`,
    ///   `ArraySlice<UInt8>`, etc.
    /// - Returns: The finalized checksum value.
    func calculate<S: Sequence<UInt8>>(for bytes: S) -> Value
}
