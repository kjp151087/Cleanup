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
    
}
