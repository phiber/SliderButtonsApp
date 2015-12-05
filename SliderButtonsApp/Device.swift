//
//  Device.swift
//  SliderButtonsApp
//
//  Created by Philipp Berger on 10.10.15.
//  Copyright © 2015 Philipp Berger. All rights reserved.
//

import Foundation

class Device {
    
    let identifier: String!
    let name: String?
    let rssi: NSNumber!
    let connectable: Bool!
    
    init(identifier: String, name: String?, rssi: NSNumber!, connectable: Bool!) {
        self.name = name
        self.identifier = identifier
        self.rssi = rssi
        self.connectable = connectable
    }
    
}
