//
//  TFASettingsHelper.swift
//  TopFreeAppStore
//
//  Created by Javier Manzo on 2/17/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import Foundation

class TFASettingsHelper {
    
    static func getBaseUrl() -> String!{
        
        if let baseUrl = getValue(withKey: .baseUrl) as? String {
            return baseUrl
        }
        return nil
    }
    
}

extension TFASettingsHelper{
    fileprivate static let plistName = "TFASettings"
    
    fileprivate enum SettingsIdentifier : String {
    
        case baseUrl = "base_url"
    }
    
    fileprivate static func getValue(withKey key: SettingsIdentifier) -> Any!{
        
        let key = key.rawValue
        
        let path = Bundle.main.path(forResource: plistName, ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path!)
        if let value = dict!.value(forKey: key) {
            return value
        }
        return nil
    }
}
