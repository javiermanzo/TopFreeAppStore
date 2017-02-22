//
//  TFAArtist.swift
//  TopFreeAppStore
//
//  Created by Javier Manzo on 2/17/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import UIKit
import SwiftyJSON
import RealmSwift

class TFAArtist: Object {
    dynamic var name: String!
    dynamic var link: String!
    
    static func create(json: JSON) -> TFAArtist {
        
        let artist = TFAArtist()
        artist.name = json["label"].stringValue
        artist.link = json["attributes"]["href"].stringValue
        return artist
    }

}
