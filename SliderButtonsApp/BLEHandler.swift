//
//  BLEHandler.swift
//  SliderButtonsApp
//
//  Created by Philipp Berger on 07.11.15.
//  Copyright © 2015 Philipp Berger. All rights reserved.
//

import CoreBluetooth


class BLEHandler : NSObject, CBCentralManagerDelegate {
    
    var notifiable = [PeripheralNotifiable]()
    
    func centralManagerDidUpdateState(central: CBCentralManager) {
        switch (central.state)
        {
        case .Unsupported:
            print("BLE is unsupported")
        case .Unauthorized:
            print("BLE is unauthorized")
        case .Unknown:
            print("BLE is unknown")
        case .Resetting:
            print("BLE is resetting")
        case .PoweredOff:
            print("BLE is powered off")
        case .PoweredOn:
            print("BLE is powered on")
            print("Start Scanning")
            central.scanForPeripheralsWithServices(nil, options: nil)
        }
        
    }
    
    func register(notifiable: PeripheralNotifiable) {
        self.notifiable.append(notifiable)
    }
    
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        //devices.updateValue(RSSI.description, forKey: peripheral.identifier.UUIDString)
        print("\(peripheral.identifier.UUIDString) : \(peripheral.name) : \(RSSI)")
    
        for n in self.notifiable {
            n.peripheralFound(peripheral.identifier.UUIDString, name: peripheral.name, rssi: RSSI)
        }
        
    }
    
//    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
//        print("\(peripheral.name) : \(RSSI) dBm")
//        print("\(peripheral.identifier)")
//
//        self.notifiable?.peripheralFound(peripheral.identifier.UUIDString, name: peripheral.name, rssi: RSSI)
//    }
    
    
}