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
    
    
    
    func peripheralFound(identifier: String!, name: String?, rssi: NSNumber!) {
        devices.updateValue(Device(identifier: identifier, name: name, rssi: rssi), forKey: identifier)
    }

    
    func getDevices() -> [Device] {
        return Array(devices.values)
    }
    
    func count() -> Int {
        return devices.count
    }
    
    

    
}
