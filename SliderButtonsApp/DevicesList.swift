//
//  Devices.swift
//  SliderButtonsApp
//
//  Created by Philipp Berger on 14.11.15.
//  Copyright © 2015 Philipp Berger. All rights reserved.
//

import UIKit

class DevicesList: NSObject, PeripheralNotifiable  {


    var devices = [String: Device]()
    
    
    func peripheralFound(identifier: String!, name: String?, rssi: NSNumber!) {
        let photo1 = UIImage(named: "Image")!
        let device1 = Device(identifier: identifier, name: name, photo: photo1)
        devices.updateValue(device1!, forKey: identifier)
    }

    
    func getDevices() -> [Device] {
        return Array(devices.values)
    }
    
    func count() -> Int {
        return devices.count
    }
    
    

    
}
