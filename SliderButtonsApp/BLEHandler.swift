//
//  BLEHandler.swift
//  SliderButtonsApp
//
//  Created by Philipp Berger on 07.11.15.
//  Copyright © 2015 Philipp Berger. All rights reserved.
//

import CoreBluetooth


class BLEHandler : NSObject, CBCentralManagerDelegate {
    
    var notifiable : PeripheralNotifiable?
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch (central.state)
        {
        case .unsupported:
            print("BLE is unsupported")
        case .unauthorized:
            print("BLE is unauthorized")
        case .unknown:
            print("BLE is unknown")
        case .resetting:
            print("BLE is resetting")
        case .poweredOff:
            print("BLE is powered off")
        case .poweredOn:
            print("BLE is powered on")
            print("Start Scanning")
            central.scanForPeripherals(withServices: nil, options: nil)
        }
        
    }
    
    func register(_ notifiable: PeripheralNotifiable) {
        self.notifiable = notifiable
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        let connectableNumber = advertisementData[CBAdvertisementDataIsConnectable] as? NSNumber
        let connectable = connectableNumber?.boolValue
        var serviceIds = [String] ()
        
     
        serviceIds = self.stringsFromUUIDs(advertisementData[CBAdvertisementDataServiceUUIDsKey] as? NSArray)
        
        let uartCapable = serviceIds.contains() {(id: String) -> Bool in return uartServiceUUID().equalsString(id, caseSensitive: false, omitDashes: true)}


        
        logger.debug("\(peripheral.identifier.uuidString) : \(peripheral.name) : \(RSSI) : \(connectable ?? false)")
        
        self.notifiable?.peripheralFound(peripheral.identifier.uuidString, name: peripheral.name, rssi: RSSI, connectable: connectable ?? false, uartCapable: uartCapable ?? false)
        
        
    }
    
    
    // uartServiceUUID() and stringsFromUUIDs copied from Adafruit BLEDevice
    func uartServiceUUID()->CBUUID {
        return CBUUID(string: "6e400001-b5a3-f393-e0a9-e50e24dcca9e")
    }
    

    
    
    func stringsFromUUIDs(_ list: NSArray?) -> [String] {
        let strings = list?.map({(o: Any) -> String in
            let uuid = o as! CBUUID
            return uuid.uuidString
            }
        )
        return strings ?? [String]()
    }

    
}

// Extend CBUUID similar to Adafruit BLEDevice
extension CBUUID {
    func equalsString(_ toString:String, caseSensitive:Bool, omitDashes:Bool)->Bool {
        var aString = toString
        var verdict = false
        var options = NSString.CompareOptions.caseInsensitive
    
        if omitDashes == true {
            aString = toString.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
        }
    
        if caseSensitive == true {
            options = NSString.CompareOptions.literal
        }
    
        verdict = aString.compare(self.representativeString() as String, options: options, range: nil, locale: Locale.current) == ComparisonResult.orderedSame
    
        return verdict
    
    }
        
    func representativeString() ->NSString{
        
        let data = self.data
        var byteArray = [UInt8](repeating: 0x0, count: data.count)
        (data as NSData).getBytes(&byteArray, length:data.count)
        
        let outputString = NSMutableString(capacity: 16)
        
        for value in byteArray {
            
            switch (value){
                case 9:
                    outputString.appendFormat("%02x-", value)
                    break
                default:
                    outputString.appendFormat("%02x", value)
            }
            
        }
        
        return outputString
    }
        
     
}
