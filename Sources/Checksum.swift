//
//  File.swift
//  
//
//  Created by Paul Kraft on 26.07.23.
//

import Foundation

public protocol Checksum {
    associatedtype Value: FixedWidthInteger

    func calculate<S: Sequence<UInt8>>(for data: S) -> Value
}
