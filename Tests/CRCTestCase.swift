//
// CRCTestCase.swift
//
// Copyright © 2020 QuickBird Studios. All rights reserved.
//

import XCTest
@testable import CRC

class CRCTestCase<Value: FixedWidthInteger>: XCTestCase {

    func printLookupTable(for crc: CRC<Value>) {
        let lookupTable = crc.lookupTable
        print("[")
        for row in 0..<32 {
            let string = "\t"
                + lookupTable[(row * 8)..<((row + 1) * 8)]
                    .map { "0x\($0.hex)" }
                    .joined(separator: ", ")
                + ","

            print(string)
        }
        print("]")
    }

    func verifyCalculator(for inputData: Data, with crcs: [CRC<Value>]) {
        var calculator: CRCCalculator<Value>!
        for crc in crcs {
            let expectedResult = crc.calculate(for: inputData)
            calculator?.reset(switchingTo: crc)
            calculator = calculator ?? CRCCalculator(crc)
            calculator.append(inputData)
            XCTAssertNoThrow(try calculator.verify(expectedResult))
            let actualResult = calculator.finalValue
            guard expectedResult == actualResult else { continue }

            for _ in 1..<100 {
                var wrongResult = expectedResult
                while wrongResult == expectedResult {
                    wrongResult = Value.random(in: Value.min...Value.max)
                }
                XCTAssertThrowsError(try calculator.verify(wrongResult)) { error in
                    switch error {
                    case let error as VerificationError<Value>:
                        XCTAssertEqual(error.expectedValue, wrongResult)
                        XCTAssertEqual(error.actualValue, expectedResult)

                        let prefix = "VerificationError<" + String(describing: Value.self) + ">"
                        let expectedString = "expected: 0x" + wrongResult.hex
                        let actualString = "actual: 0x" + actualResult.hex
                        XCTAssertEqual(
                            String(describing: error),
                            prefix + "(" + expectedString + ", " + actualString + ")"
                        )
                    default:
                        XCTFail("Unexpected error: \(error)")
                    }
                }
            }
        }
    }

    func verifyLookupTable(for crc: CRC<Value>, equalsTo lookupTable: [Value]) {
        XCTAssertEqual(crc.lookupTable, lookupTable)
    }

    func verify(for inputData: Data, expected expectedResults: [(Value, CRC<Value>)]) {
        for (expectedResult, crc) in expectedResults {
            let actualResult = crc.calculate(for: inputData)
            XCTAssertEqual(actualResult, expectedResult)
            guard actualResult == expectedResult else { continue }

            XCTAssertNoThrow(try crc.verify(expectedResult, for: inputData))
            for _ in 1..<100 {
                var wrongResult = expectedResult
                while wrongResult == expectedResult {
                    wrongResult = Value.random(in: Value.min...Value.max)
                }
                XCTAssertThrowsError(try crc.verify(wrongResult, for: inputData)) { error in
                    switch error {
                    case let error as VerificationError<Value>:
                        XCTAssertEqual(error.expectedValue, wrongResult)
                        XCTAssertEqual(error.actualValue, expectedResult)

                        let prefix = "VerificationError<" + String(describing: Value.self) + ">"
                        let expectedString = "expected: 0x" + wrongResult.hex
                        let actualString = "actual: 0x" + actualResult.hex
                        XCTAssertEqual(
                            String(describing: error),
                            prefix + "(" + expectedString + ", " + actualString + ")"
                        )
                    default:
                        XCTFail("Unexpected error: \(error)")
                    }
                }
            }
        }
    }

}
