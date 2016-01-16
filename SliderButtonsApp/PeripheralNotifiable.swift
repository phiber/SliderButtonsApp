//
//  PeripheralNotifiable.swift
//  SliderButtonsApp
//
//  Created by Philipp Berger on 07.11.15.
//  Copyright © 2015 Philipp Berger. All rights reserved.
//

import Foundation


protocol PeripheralNotifiable: NSObjectProtocol {
    func peripheralFound(identifier:String!, name: String?, rssi: NSNumber!, connectable: Bool!, uartCapable: Bool!)
}
