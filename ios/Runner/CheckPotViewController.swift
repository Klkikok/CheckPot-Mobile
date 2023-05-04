//
//  GGOneViewController.swift
//  Runner
//
//  Created by Boris Culjak on 3.2.23.
//

import UIKit
import CoreBluetooth
import Foundation
import EventKit
import Flutter



public struct ImpactService {
    public static let service = CBUUID(string: "19B10000-E8F2-537E-4F6C-D104768A1200")
}

class CheckPotViewController: FlutterViewController,  CBCentralManagerDelegate, CBPeripheralDelegate, FlutterStreamHandler {
    private var centralManager : CBCentralManager!
    private var characteristic : CBCharacteristic!
    private var peripheral : CBPeripheral?
    private var eventSink: FlutterEventSink? = nil
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.main)
        
    }
    
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        
        
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }
    
    
    
    public func sendEvent(event: Any?) throws {

        if eventSink != nil {
            eventSink?(event)
        }
    }
    
    public func error(code: String, message: String?, details: Any? = nil) {
        if eventSink != nil {
            eventSink?(FlutterError(code: code, message: message, details: details))
        }
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch self.centralManager.state {
        case .poweredOff:
            print("BLE is powered off")
        case .poweredOn:
            print("BLE is poweredOn")
        case .resetting:
            print("BLE is resetting")
        case .unauthorized:
            print("BLE is unauthorized")
        case .unknown:
            print("BLE is unknown")
        case .unsupported:
            print("BLE is unsupported")
        default:
            print("default")
        }
        if ( self.centralManager?.state == .poweredOn){
            self.peripheral = nil
            print("startujem scan")
            self.centralManager?.scanForPeripherals(withServices: [ImpactService.service], options: nil)
        }
        if(self.centralManager?.state == .poweredOff)
        {
            print("Iskljucio se bluetooth")
            self.peripheral = nil
        
        }
    }
   
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
      guard peripheral.name != nil else {return}
      
      
      
        print("IDENTIFIERR")
        print(peripheral.identifier.uuid)
        //stopScan
          centralManager.stopScan()
        
        //connect
        centralManager.connect(peripheral, options: nil)
        self.peripheral = peripheral
       
       
    }
    
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
      //discover all service
        print("Konektovao sam se na")
        print(peripheral)
        peripheral.delegate = self
        self.peripheral = peripheral
        peripheral.discoverServices(nil)
        

    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
         
          if let services = peripheral.services {
         
          //discover characteristics of services
          for service in services {
           peripheral.discoverCharacteristics(nil, for: service)
         }
     }
   }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
       if let charac = service.characteristics {
        for characteristic in charac {
            print(characteristic.uuid)
            if(characteristic.uuid == CBUUID(string: "19B10001-E8F2-537E-4F6C-D104768A1202"))
            {
                print("Pretplatio se")
                peripheral.setNotifyValue(true, for: characteristic)
            }
            if(characteristic.uuid == CBUUID(string: "19B10001-E8F2-537E-4F6C-D104768A1203"))
            {
                print("Pretplatio se")
                peripheral.setNotifyValue(true, for: characteristic)
            }
            
            if(characteristic.uuid == CBUUID(string: "19B10001-E8F2-537E-4F6C-D104768A1204"))
            {
                print("Pretplatio se")
                peripheral.setNotifyValue(true, for: characteristic)
            }
            if(characteristic.uuid == CBUUID(string: "19B10001-E8F2-537E-4F6C-D104768A1205"))
            {
                print("Pretplatio se")
                peripheral.setNotifyValue(true, for: characteristic)
            }
          //MARK:- Light Value
            
        }
      }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
        if let error = error {
            // Handle error
            print("EEEEERRRRROOOOOOORRRRRRR")
            print(error)
            return
        }
        
        guard let value = characteristic.value else {
            print("VALUE JE NULL")
            return
        }
        
//        print(value)
//        print(value.hexEncodedString())
//        print(characteristic.uuid)
        if(characteristic.uuid == CBUUID(string: "19B10001-E8F2-537E-4F6C-D104768A1202"))
        {
            if let temperature = UInt8(value.hexEncodedString(), radix: 16) {
                print("Temperature: ")
                print(temperature)
                print("")
                
                do
                {
                    try sendEvent(event: [0, temperature])
                    
                } catch
                {
                    print("Error")
                }
                
            }
        }
        else if(characteristic.uuid == CBUUID(string: "19B10001-E8F2-537E-4F6C-D104768A1203"))
        {
            if let humidity = UInt8(value.hexEncodedString(), radix: 16) {
                print("Humidity: ")
                print(humidity)
                print("")
                do
                {
                    try sendEvent(event: [1,  humidity])
                    
                } catch
                {
                    print("Error")
                }
                
            }
            
        }
        else if(characteristic.uuid == CBUUID(string: "19B10001-E8F2-537E-4F6C-D104768A1204"))
        {
            if let soilMoisture = UInt8(value.hexEncodedString(), radix: 16) {
                print("Soil moisture: ")
                print(soilMoisture)
                print("")
                do
                {
                    try sendEvent(event: [2,  soilMoisture])
                    
                } catch
                {
                    print("Error")
                }
                
            }
            
        }
        else if(characteristic.uuid == CBUUID(string: "19B10001-E8F2-537E-4F6C-D104768A1205"))
        {
            if let light = UInt8(value.hexEncodedString(), radix: 16) {
                print("Light: ")
                print(light)
                print("")
                do
                {
                    try sendEvent(event: [3,  light])
                    
                } catch
                {
                    print("Error")
                }
                
            }
            
        }
        
    }
    
    
    
}
extension Data {
    struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }
    
    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
        return self.map { String(format: format, $0) }.joined()
    }
}

