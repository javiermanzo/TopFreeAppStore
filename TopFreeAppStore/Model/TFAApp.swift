//
//  TFAApp.swift
//  TopFreeAppStore
//
//  Created by Javier Manzo on 2/17/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import UIKit
import SwiftyJSON
import RealmSwift

class TFAApp: Object {
    dynamic var id: String!
    dynamic var bundleId: String!
    dynamic var name: String!
    dynamic var title: String!
    dynamic var imageUrl: String!
    dynamic var summary: String!
    dynamic var artist: TFAArtist!
    dynamic var rights: String!
    dynamic var link: String!
    dynamic var category: TFACategory!
    dynamic var releaseDate: String!
    
    
    static func create(json: JSON) -> TFAApp {
        
        let app = TFAApp()
        
        app.id = json["id"]["attributes"]["im:id"].stringValue
        app.bundleId = json["id"]["attributes"]["im:bundleId"].stringValue
        app.name = json["im:name"]["label"].stringValue
        app.summary = json["summary"]["label"].stringValue
        app.title = json["title"]["label"].stringValue
        app.imageUrl = json["im:image"].arrayValue[2]["label"].stringValue
        app.artist = TFAArtist.create(json: json["im:artist"])
        app.rights = json["rights"]["label"].stringValue
        app.link = json["link"]["attributes"]["href"].stringValue
        app.category = TFACategory.create(json: json["category"]["attributes"])
        app.releaseDate = json["im:releaseDate"]["attributes"]["label"].stringValue
        return app
    }
}
