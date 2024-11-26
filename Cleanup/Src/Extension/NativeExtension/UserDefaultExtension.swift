//
//  UserDefaultExtension.swift
//  PharmaVision
//
//  Created by Kunal Personl on 17/08/24.
//

import Foundation

extension UserDefaults{
    func setObject(obj : Any, key : String) {
        if let data = convertAnyToData(obj) {
            UserDefaults.standard.setValue(data, forKey: key)
            UserDefaults.standard.synchronize()
        }
        else{
            print("Can not convert Data")
        }
    }
    
    func getObject(key : String) -> Any? {
        if let data =  UserDefaults.standard.value(forKey: key) as? Data{
            return convertDataToAny(data)
        }
        return nil
    }
    
    
    func convertAnyToData(_ value: Any) -> Data? {
        if JSONSerialization.isValidJSONObject(value) {
            do {
                let data = try JSONSerialization.data(withJSONObject: value, options: [])
                return data
            } catch {
                print("Error converting to Data: \(error)")
            }
        } else {
            print("The value is not a valid JSON object")
        }
        return nil
    }
    
    
    func convertDataToAny(_ data: Data) -> Any? {
        
        do {
            let obj = try JSONSerialization.jsonObject(with: data)
            return obj
        } catch {
            print("Error converting to Data: \(error)")
        }
        
        return nil
    }
    
    
}
