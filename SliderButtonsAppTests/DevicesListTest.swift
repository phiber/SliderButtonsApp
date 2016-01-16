//
//  DevicesListTest.swift
//  SliderButtonsApp
//
//  Created by Philipp Berger on 14.11.15.
//  Copyright © 2015 Philipp Berger. All rights reserved.
//

import Foundation
import XCTest


class DevicesListTest: XCTestCase {
    
    
    func testSameIdentifierOnlyOneDevice() {
        let deviceList = DevicesList()
        
        deviceList.peripheralFound("1", name: "SomeDevice", rssi: 42, connectable: true, uartCapable: false)
        deviceList.peripheralFound("1", name: nil, rssi: 12, connectable: true, uartCapable: false)
        
        XCTAssert(deviceList.count() == 1)
    }
    
}
