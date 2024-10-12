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
    
    func getSavedData() -> [[String:Any]] {
        if let userData = UserDefaults.standard.getObject(key: "SavedData") as? [[String:Any]] {
            return userData
        }
        return []
    }
   
    func saveDocumentForLater(strID : String = "", title : String? , notes : String?, filePath : String?) {
        
        
        var sID = strID.isEmpty ? "\(Date().timeIntervalSince1970)" : strID
        var subject = title ?? ""
        subject = subject.isEmpty ? Date.currentDateTime() : subject
        
        
        let obj : [String:Any] = [
            "ObjID" : sID,
            "subject" : subject,
            "notes" : notes ?? "",
            "filePath" : ((filePath as? NSString) ?? "").lastPathComponent 
        ]
        
        var oldList = getSavedData().filter{($0["ObjID"] as? String ?? "") != sID}
        oldList.append(obj)
        
        UserDefaults.standard.setObject(obj: oldList, key: "SavedData")
    }
    
    func deleteDocumentForLater(strID : String) {
        
        var oldList = getSavedData().filter{($0["ObjID"] as? String ?? "") != strID}
        UserDefaults.standard.setObject(obj: oldList, key: "SavedData")
    }
    
    func draftListCount() -> Int {
        return getSavedData().count
    }
    
    
//    func saveDocumentForLater( data : [String:Any])  {
//        var strID = ""
//        if let sID = data["ID"] as? String {
//            strID = sID
//        }
//        else{
//            strID = "\(Date().timeIntervalSince1970)"
//            
//        }
//        
//        let newData : [String:Any] = [:]
//        newData["title"] = data[
//        
//        
//    }
    
}
