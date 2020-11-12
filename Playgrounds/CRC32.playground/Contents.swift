//
// CRC32.playground
//
// Copyright © 2020 QuickBird Studios. All rights reserved.
//

import Foundation

let crc32 = CRC32()

crc32.currentValue      // initial value is 0
crc32.append(1.0)
crc32.append(1)       // we are passing integer (If you want to pass UInt8, see the line below)
crc32.append(UInt8(1))
crc32.append([1, 20]) // We are passing [UInt8] (because that is the only type of array the append method accepts)

// get the current crc value
crc32.currentValue

// append more
crc32.append(5.6)
crc32.append(225)

// get the current crc value
crc32.currentValue

// reset the crc value
crc32.reset()

crc32.currentValue  // value is 0 after reset


// CRC32's lookup table
crc32.lookupTable

// CRC32's lookup table (hexadecimal representation)
let lookupTableHexa = crc32.lookupTable.map { String($0, radix: 16) }
