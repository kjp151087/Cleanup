//
//  DataManager.swift
//  Cleanup
//
//  Created by Kunal Personl on 25/10/24.
//

import Foundation



class DataManager {
    static var shared = DataManager()
    
    private let deletedAssetIdsKey = "DeletedAssetIds"
    private let parentsIdsKey = "ParentsIdsKey"
    private let scanIdsKey = "ScanIdsKey"
    private let assetsIdKey = "AssetsIdKey"
    
    var deletedAssetIDAssetID : [String] = []
    var parentsID : [String] = []
    var scanedID : [String] = []
    var assetIDParentID : [String] = []
    
    private init() {
        parentsID = UserDefaults.standard.getObject(key: parentsIdsKey) as? [String] ?? []
    }
    
    func deletedAssetList() -> [String] {
        if let oldList = UserDefaults.standard.getObject(key: deletedAssetIdsKey) as? [String] {
            return oldList
        }
        return []
    }
    
    func deleteAssetId(assetID : String) {
        updateAssetIdList(list: [assetID])
    }
    
    func updateAssetIdList(list : [String]) {
        var oldList = deletedAssetList()
        oldList.append(contentsOf: list)
        
        let uniqueList = Array(Set(oldList))
        print("uniqueList \(uniqueList)")
        UserDefaults.standard.setObject(obj: uniqueList, key: deletedAssetIdsKey)
    }
    
    func updateScanID(assetID : String, parentID : String) {
        var parentsList : [String] = []
        if let list = UserDefaults.standard.getObject(key: parentsIdsKey) as? [String] {
            parentsList = list
        }
        
        if(!parentsList.contains(parentID)) {
            parentsList.append(parentID)
        }
        UserDefaults.standard.setObject(obj: parentsList, key: parentsIdsKey)
        
        if var objScanId = UserDefaults.standard.getObject(key: assetsIdKey) as? [String:String] {
            objScanId[assetID] = parentID
            UserDefaults.standard.setObject(obj: objScanId, key: assetsIdKey)
        }
        else{
            let obj = [assetID:parentID]
            UserDefaults.standard.setObject(obj: obj, key: assetsIdKey)
        }
    }
    
    func getParentId(for assetID : String) -> String? {
        if let objScanId = UserDefaults.standard.getObject(key: assetsIdKey) as? [String:String] {
            return objScanId[assetID]
        }
        
        return nil
    }
    
    func addToScanList(for assetID : String){
        var scanList : [String] = []
        if let list = UserDefaults.standard.getObject(key: parentsIdsKey) as? [String] {
            scanList = list
        }
        
        if(!scanList.contains(assetID)) {
            scanList.append(assetID)
            UserDefaults.standard.setObject(obj: scanList, key: parentsIdsKey)
        }
    }
    
    
    func isAssetIdAlreadyScaned(for assetID : String) -> Bool{
        if let list = UserDefaults.standard.getObject(key: parentsIdsKey) as? [String] {
            if(!list.contains(assetID)) {
                return true
            }
        }
        
        return false
    }
    
}
