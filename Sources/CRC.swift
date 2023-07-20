//
// CRC.swift
//
// Copyright © 2020 QuickBird Studios. All rights reserved.
//

import Foundation

public struct CRC<Value: FixedWidthInteger> {

    // MARK: Stored Properties

    public let initialValue: Value
    public let reflected: Bool
    public let xorOut: Value

    public let lookupTable: [Value]

    // MARK: Initialization

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

    public func complete(_ value: inout Value) {
        value ^= xorOut
    }

    public func calculate<S: Sequence<UInt8>>(for bytes: S) -> Value {
        var value = initialValue
        calculate(for: bytes, in: &value)
        complete(&value)
        return value
    }

}

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
