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
        self.notifiable = notifiable
    }
    
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        
        let connectableNumber = advertisementData[CBAdvertisementDataIsConnectable] as? NSNumber
        let connectable = connectableNumber?.boolValue
        var serviceIds = [String] ()
        
     
        serviceIds = self.stringsFromUUIDs(advertisementData[CBAdvertisementDataServiceUUIDsKey] as? NSArray)
        
        let uartCapable = serviceIds.contains() {(id: String) -> Bool in return uartServiceUUID().equalsString(id, caseSensitive: false, omitDashes: true)}


        
        logger.debug("\(peripheral.identifier.UUIDString) : \(peripheral.name) : \(RSSI) : \(connectable ?? false)")
        
        self.notifiable?.peripheralFound(peripheral.identifier.UUIDString, name: peripheral.name, rssi: RSSI, connectable: connectable ?? false, uartCapable: uartCapable ?? false)
        
        
    }
    
    
    // uartServiceUUID() and stringsFromUUIDs copied from Adafruit BLEDevice
    func uartServiceUUID()->CBUUID {
        return CBUUID(string: "6e400001-b5a3-f393-e0a9-e50e24dcca9e")
    }
    
    func stringsFromUUIDs(list: NSArray?) -> [String] {
        let strings = list?.map({ (o: AnyObject) -> String in
            let uuid = o as! CBUUID
            return uuid.UUIDString
            }
        )
        return strings ?? [String]()
        

    }

    
}

// Extend CBUUID similar to Adafruit BLEDevice
extension CBUUID {
    func equalsString(toString:String, caseSensitive:Bool, omitDashes:Bool)->Bool {
        var aString = toString
        var verdict = false
        var options = NSStringCompareOptions.CaseInsensitiveSearch
    
        if omitDashes == true {
            aString = toString.stringByReplacingOccurrencesOfString("-", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        }
    
        if caseSensitive == true {
            options = NSStringCompareOptions.LiteralSearch
        }
    
        verdict = aString.compare(self.representativeString() as String, options: options, range: nil, locale: NSLocale.currentLocale()) == NSComparisonResult.OrderedSame
    
        return verdict
    
    }
        
    func representativeString() ->NSString{
        
        let data = self.data
        var byteArray = [UInt8](count: data.length, repeatedValue: 0x0)
        data.getBytes(&byteArray, length:data.length)
        
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
