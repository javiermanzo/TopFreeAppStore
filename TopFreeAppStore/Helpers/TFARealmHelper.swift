//
//  TFARealmHelper.swift
//  TopFreeAppStore
//
//  Created by Javier Manzo on 2/20/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class TFARealmHelper {
    
    static let shared = TFARealmHelper()
    
    let realm = try! Realm()
    
    func persistAppsListData(data: NSArray) -> Results<TFAApp>{
        
        var appsList: Results<TFAApp> = { self.realm.objects(TFAApp.self) }()
        
        try! realm.write() {
            
            realm.deleteAll()
            
            for appData in data {
                let app = TFAApp.create(json: appData as! JSON)
                self.realm.add(app)
            }
        }
        
        appsList = realm.objects(TFAApp.self)
        
        return appsList
    }
    
    func getAppsList() -> Results<TFAApp>{
        var appsList: Results<TFAApp> = { self.realm.objects(TFAApp.self) }()
        
        appsList = realm.objects(TFAApp.self)
        
        return appsList
    }
    
}
