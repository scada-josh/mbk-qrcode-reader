//
//  EmployeeSummary.swift
//  MBK
//
//  Created by Macbook Air on 12/22/2558 BE.
//  Copyright © 2558 Code-Aholic. All rights reserved.
//

import Foundation
import SwiftyJSON

class EmployeeSummary {
    var countEmployees: String?
    var countDivision: String?
//    var rowsDivision: String?
//    var rowsCountEmployees: String?
    
    required init(json: JSON) {
        self.countEmployees = json["countEmployees"].string
        self.countDivision = json["countDivision"].string
//        self.rowsDivision = json["rows"]["rowsDivision"].string
//        self.rowsCountEmployees = json["rows"]["rowsCountEmployees"].string
    }
    
    required init() {
    }
}