//
//  BLEManager.swift
//  SliderButtonsApp
//
//  Created by Philipp Berger on 07.11.15.
//  Copyright © 2015 Philipp Berger. All rights reserved.
//
import CoreBluetooth

class BLEManager {
    var centralManager : CBCentralManager!
    var bleHandler : BLEHandler // delegate
    init() {
        self.bleHandler = BLEHandler()
        self.centralManager = CBCentralManager(delegate: self.bleHandler, queue: nil)
    }
    
    func register(_ notifiable: PeripheralNotifiable) {
        self.bleHandler.register(notifiable)
    }
    
}
