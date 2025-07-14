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
    private let memorySizeStoreKey = "MemorySizeStoreKey"
    
    var deletedAssetIDAssetID : [String] = []
    var parentsIDList : [String] = []
    var scanedIDList : [String] = []
    var assetIDParentID : [String:String] = [:]
    var assetIDMemorySize : [String:Float] = [:]
    
    private init() {
        parentsIDList = UserDefaults.standard.getObject(key: parentsIdsKey) as? [String] ?? []
        assetIDParentID = UserDefaults.standard.getObject(key: assetsIdKey) as? [String:String] ?? [:]
        assetIDMemorySize = UserDefaults.standard.getObject(key: memorySizeStoreKey) as? [String:Float] ?? [:]
        scanedIDList = UserDefaults.standard.getObject(key: scanIdsKey) as? [String] ?? []
        
        print("assetIDMemorySize -> \(assetIDMemorySize)")
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
        
        if(!parentsIDList.contains(parentID)) {
            parentsIDList.append(parentID)
        }
        UserDefaults.standard.setObject(obj: parentsIDList, key: parentsIdsKey)
        
        assetIDParentID[assetID] = parentID
        UserDefaults.standard.setObject(obj: assetIDParentID, key: assetsIdKey)
        
    }
    
    func getParentId(for assetID : String) -> String? {
        return assetIDParentID[assetID]
    }
    
    func addToScanList(for assetID : String){
        if(!scanedIDList.contains(assetID)) {
            scanedIDList.append(assetID)
            UserDefaults.standard.setObject(obj: scanedIDList, key: scanIdsKey)
        }
    }
        
    func isAssetIdAlreadyScaned(for assetID : String) -> Bool{
        if(scanedIDList.contains(assetID)) {
            return true
        }
        return false
    }
    
    func updateMemoryID(assetID : String, memorySize : Float){
        assetIDMemorySize[assetID] = memorySize
        UserDefaults.standard.setObject(obj: assetIDMemorySize, key: memorySizeStoreKey)
    }
    
    func memorySize(assetID : String) -> Float?{
        return assetIDMemorySize[assetID]
    }
    
}
