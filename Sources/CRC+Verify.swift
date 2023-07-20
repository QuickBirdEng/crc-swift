//
//  File.swift
//  
//
//  Created by Paul Kraft on 17.07.23.
//

import Foundation

public struct VerificationError<Value: FixedWidthInteger>: Error, CustomStringConvertible {

    public let actualValue: Value
    public let expectedValue: Value

    public var description: String {
        "\(String(describing: Self.self))(expected: 0x\(expectedValue.hex), actual: 0x\(actualValue.hex))"
    }

}

extension CRC {

    public func verify<S: Sequence<UInt8>>(_ expectedValue: Value, for bytes: S) throws {
        let actualValue = calculate(for: bytes)
        guard expectedValue == actualValue else {
            throw VerificationError(
                actualValue: actualValue,
                expectedValue: expectedValue
            )
        }
    }

}

extension CRCCalculator {

    public func verify(_ expectedValue: Value) throws {
        let actualValue = finalValue
        guard expectedValue == actualValue else {
            throw VerificationError(
                actualValue: actualValue,
                expectedValue: expectedValue
            )
        }
    }

}

extension FixedWidthInteger {

    internal var hex: String {
        withUnsafeBytes(of: bigEndian) { $0.hex }
    }

}

extension Sequence<UInt8> {

    internal var hex: String {
        self
            .map { String(format: "%02hhX", $0) }
            .joined()
    }

}
