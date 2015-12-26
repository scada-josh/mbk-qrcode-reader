//
//  Event.swift
//  MBK
//
//  Created by Macbook Air on 12/22/2558 BE.
//  Copyright © 2558 Code-Aholic. All rights reserved.
//

import Foundation
import SwiftyJSON

class Event : ResponseJSONObjectSerializable {
    var id: String?
    var event_id: String?
    var event_name_th: String?
    var event_location: String?
    var event_begin_date: String?
    
    required init(json: JSON) {
        self.id = json["id"].string
        self.event_id = json["event_id"].string
        self.event_name_th = json["event_name_th"].string
        self.event_location = json["event_location"].string
        self.event_begin_date = json["event_begin_date"].string
    }
    
    required init() {
        
    }
}