//
//  TFACategory.swift
//  TopFreeAppStore
//
//  Created by Javier Manzo on 2/17/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import UIKit
import SwiftyJSON
import RealmSwift

class TFACategory: Object {
    dynamic var id: String!
    dynamic var name: String!
    dynamic var link: String!
    
    static func create(json: JSON) -> TFACategory {
        
        let category = TFACategory()
        category.id = json["im:id"].stringValue
        category.name = json["label"].stringValue
        category.link = json["scheme"].stringValue
        return category
    }
    
}
