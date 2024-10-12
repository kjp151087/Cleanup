//
//  EncodableExtension.swift
//  PharmaVision
//


import Foundation

extension Encodable {
    func toDictionary() -> [String: Any]? {
        do {
            let data = try JSONEncoder().encode(self)
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            return jsonObject as? [String: Any]
        } catch {
            print("Error converting model to dictionary: \(error)")
            return nil
        }
    }
}
