//
//  World.swift
//  Overload
//
//  Created by Draveness on 11/12/16.
//  Copyright © 2016 Draveness. All rights reserved.
//

import UIKit
import SwiftyJSON

struct World {
    let id: Int
    let banner: URL
    let name: String
    let title: String
    let desc: String

    init(json: JSON) {
        let id = json["world_id"].intValue
        let banner = URL(string: json["banner_url"].stringValue)!
        let name = json["world_name"].stringValue
        let desc = json["world_desc"].stringValue
        let title = json["world_title"].stringValue

        self.id = id
        self.banner = banner
        self.name = name
        self.desc = desc
        self.title = title
    }

}
