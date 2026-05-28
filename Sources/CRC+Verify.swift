//
// CRC+Verify.swift
//
// Copyright © 2023 QuickBird Studios. All rights reserved.
//

/// The error thrown by ``Checksum/verify(_:for:)`` and
/// ``CRCCalculator/verify(_:)`` when the computed checksum does not match
/// the expected value.
public struct VerificationError<Value: FixedWidthInteger & Sendable>: Error, CustomStringConvertible {

    // MARK: Stored Properties

    /// The checksum that was actually computed from the payload.
    public let actualValue: Value

    /// The checksum the caller expected — i.e. the argument they passed to
    /// `verify`.
    public let expectedValue: Value

    // MARK: Computed Properties

    public var description: String {
        "Checksum verification failed (expected: 0x\(expectedValue.hex), actual: 0x\(actualValue.hex))"
    }

    // MARK: Initialization

    internal init(actual: Value, expected: Value) {
        self.actualValue = actual
        self.expectedValue = expected
    }

}

extension VerificationError: Sendable {}

extension Checksum {

    /// Computes the checksum of `bytes` and throws a ``VerificationError`` if
    /// it does not match `expectedValue`.
    ///
    /// - Parameters:
    ///   - expectedValue: The checksum the caller expects to receive.
    ///   - bytes: The payload to checksum.
    /// - Throws: ``VerificationError`` carrying both the expected and actual
    ///   values.
    public func verify<S: Sequence<UInt8>>(_ expectedValue: Value, for bytes: S) throws {
        let actualValue = calculate(for: bytes)
        guard actualValue == expectedValue else {
            throw VerificationError(actual: actualValue, expected: expectedValue)
        }
    }

}

extension CRCCalculator {

    /// Throws a ``VerificationError`` if the calculator's ``finalValue`` does
    /// not match `expectedValue`.
    ///
    /// - Throws: ``VerificationError`` carrying both the expected and actual
    ///   values.
    public func verify(_ expectedValue: Value) throws {
        let actualValue = finalValue
        guard expectedValue == actualValue else {
            throw VerificationError(
                actual: actualValue,
                expected: expectedValue
            )
        }
    }

}
