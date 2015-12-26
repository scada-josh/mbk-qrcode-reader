//
//  UserInfo.swift
//  MBK
//
//  Created by Macbook Air on 12/27/2558 BE.
//  Copyright © 2558 Code-Aholic. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserInfo : ResponseJSONObjectSerializable {
    var user_id: String?
    var user_name: String?
    var user_position: String?
    var user_division: String?
    var user_org: String?
    
    
    required init(json: JSON) {
        self.user_id = json["user_id"].string
        self.user_name = json["user_name"].string
        self.user_position = json["user_position"].string
        self.user_division = json["user_division"].string
        self.user_org = json["user_org"].string
    }
    
    required init() {
        
    }
}
