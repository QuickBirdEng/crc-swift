//
//  File.swift
//  
//
//  Created by Paul Kraft on 20.07.23.
//

import Foundation

public typealias CRC8Calculator = CRCCalculator<UInt8>
public typealias CRC16Calculator = CRCCalculator<UInt16>
public typealias CRC32Calculator = CRCCalculator<UInt32>
public typealias CRC64Calculator = CRCCalculator<UInt64>

public struct CRCCalculator<Value: FixedWidthInteger> {

    // MARK: Stored Properties

    public private(set) var crc: CRC<Value>
    public private(set) var currentValue: Value

    // MARK: Computed Properties

    public var finalValue: Value {
        var finalValue = currentValue
        crc.complete(&finalValue)
        return finalValue
    }

    // MARK: Initialization

    public init(_ crc: CRC<Value>) {
        self.crc = crc
        self.currentValue = crc.initialValue
    }

    // MARK: Methods

    public mutating func append<S: Sequence<UInt8>>(_ bytes: S) {
        crc.calculate(for: bytes, in: &currentValue)
    }

    public mutating func reset(switchingTo newCRC: CRC<Value>? = nil) {
        if let newCRC { crc = newCRC }
        currentValue = crc.initialValue
    }

}

extension CRCCalculator {

    public mutating func append(_ bytes: UInt8...) {
        append(bytes)
    }

    public mutating func append<T: FixedWidthInteger>(bigEndian value: T) {
        withUnsafeBytes(of: value.bigEndian) { append($0) }
    }

    #if arch(arm64)
    @available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *)
    public mutating func append(bigEndian value: Float16) {
        append(bigEndian: value.bitPattern)
    }
    #endif

    public mutating func append(bigEndian value: Float32) {
        append(bigEndian: value.bitPattern)
    }

    public mutating func append(bigEndian value: Float64) {
        append(bigEndian: value.bitPattern)
    }

}
