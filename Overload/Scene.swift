//
//  Scene.swift
//  Overload
//
//  Created by Draveness on 11/13/16.
//  Copyright © 2016 Draveness. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Scene {
    let thumbnail: URL
    let id: Int
    let title: String
    let events: [Event]

    init(json: JSON) {
        self.id = json["sceneid"].intValue
        self.thumbnail = (URL(string: json["thumbnail"].stringValue) ?? URL(string: "https://www.google.com.hk/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&cad=rja&uact=8&ved=0ahUKEwidjaSQ6qPQAhUEJJQKHTIGCYcQjRwIBw&url=%68%74%74%70%3a%2f%2f%62%67%72%2e%63%6f%6d%2f%32%30%31%36%2f%30%38%2f%30%38%2f%6d%61%63%62%6f%6f%6b%2d%70%72%6f%2d%61%69%72%2d%32%30%31%36%2f&psig=AFQjCNGWScdTNHaQqJbDPMVrq_3aKIuOPQ&ust=1479061104778246"))!
        self.title = json["title"].stringValue

        let eventsJSON = json["events"].arrayValue
        self.events = eventsJSON.map { json in
            Event(json: json)
        }
    }
}

struct Event {
    let id: Int
    let title: String
    let videoURL: URL
    let text: String
    let keyword: String

    init(json: JSON) {
        self.id = json["eventid"].intValue
        self.videoURL = (URL(string: json["content"]["video"].stringValue) ?? tempVideoURL)!
        self.title = json["title"].stringValue
        self.text =  json["content"]["text"].stringValue
        self.keyword = json["keyword"].stringValue
    }
}

struct Meal {
    let id: Int
    let name: String
    let icon: URL
    let desc: String
    let price: Float
    init(json: JSON) {
        self.id = json["eventid"].intValue
        self.icon = URL(string: json["icon_url"].stringValue)!
        self.price = json["price"].floatValue
        self.desc =  json["description"].stringValue
        self.name = json["name"].stringValue
    }
}
