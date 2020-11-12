//
// CRC8.playground
//
// Copyright © 2020 QuickBird Studios. All rights reserved.
//

import Foundation

let crc8 = CRC8()

crc8.currentValue      // initial value is 0
crc8.append(1.0)
crc8.append(1)       // we are passing integer (If you want to pass UInt8, see the line below)
crc8.append(UInt8(1))
crc8.append([1, 20]) // We are passing [UInt8] (because that is the only type of array the append method accepts)

// get the current crc value
crc8.currentValue

// append more
crc8.append(5.6)
crc8.append(225)

// get the current crc value
crc8.currentValue

// reset the crc value
crc8.reset()

crc8.currentValue  // value is 0 after reset


// CRC8's lookup table
crc8.lookupTable

// CRC8's lookup table (hexadecimal representation)
let lookupTableHexa = crc8.lookupTable.map { String($0, radix: 16) }
lookupTableHexa
