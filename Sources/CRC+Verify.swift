//
//  File.swift
//  
//
//  Created by Paul Kraft on 17.07.23.
//

import Foundation

public struct VerificationError<Value: FixedWidthInteger>: Error, CustomStringConvertible {

    // MARK: Stored Properties

    public let actualValue: Value
    public let expectedValue: Value

    // MARK: Computed Properties

    public var description: String {
        "\(String(describing: Self.self))(expected: 0x\(expectedValue.hex), actual: 0x\(actualValue.hex))"
    }

    // MARK: Initialization

    internal init(actual: Value, expected: Value) {
        self.actualValue = actual
        self.expectedValue = expected
    }

}

extension Checksum {

    public func verify<S: Sequence<UInt8>>(_ expectedValue: Value, for data: S) throws {
        let actualValue = calculate(for: data)
        guard actualValue == expectedValue else {
            throw VerificationError(actual: actualValue, expected: expectedValue)
        }
    }

}

extension CRCCalculator {

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
