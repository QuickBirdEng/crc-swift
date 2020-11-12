//
// CRC16.swift
//
// Copyright © 2020 QuickBird Studios. All rights reserved.
//

import Foundation

let crc16 = CRC16()

crc16.currentValue      // initial value is 0
crc16.append(1.0)
crc16.append(1)       // we are passing integer (If you want to pass UInt8, see the line below)
crc16.append(UInt8(1))
crc16.append([1, 20]) // We are passing [UInt8] (because that is the only type of array the append method accepts)

// get the current crc value
crc16.currentValue

// append more
crc16.append(5.6)
crc16.append(225)

// get the current crc value
crc16.currentValue

// reset the crc value
crc16.reset()

crc16.currentValue  // value is 0 after reset


// CRC16's lookup table
crc16.lookupTable

// CRC16's lookup table (hexadecimal representation)
let lookupTableHexa = crc16.lookupTable.map { String($0, radix: 16) }
lookupTableHexa
