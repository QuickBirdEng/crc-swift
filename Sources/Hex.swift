//
//  File.swift
//  
//
//  Created by Paul Kraft on 26.07.23.
//

import Foundation

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
