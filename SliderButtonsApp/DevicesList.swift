//
//  Devices.swift
//  SliderButtonsApp
//
//  Created by Philipp Berger on 14.11.15.
//  Copyright © 2015 Philipp Berger. All rights reserved.
//

import Foundation

class DevicesList: NSObject, PeripheralNotifiable  {

    var devices = [String: Device]()
    
    func peripheralFound(_ identifier: String!, name: String?, rssi: NSNumber!, connectable: Bool!, uartCapable: Bool!) {
        devices.updateValue(Device(identifier: identifier, name: name, rssi: rssi, connectable: connectable, uartCapable: uartCapable), forKey: identifier)
    }
    
    func getDevices() -> [Device] {
        devices = devices.filter({ (entry: (key: String, value: Device)) -> Bool in
                entry.value.lastSeen.addingTimeInterval(60.0).compare(Date()).rawValue > 0
            }
        )
        return Array(devices.values)
    }
    
    func count() -> Int {
        return devices.count
    }
    
    

    
}
