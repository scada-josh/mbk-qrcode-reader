//
//  ResponseJSONObjectSerializable.swift
//  MBK
//
//  Created by Macbook Air on 12/22/2558 BE.
//  Copyright © 2558 Code-Aholic. All rights reserved.
//

import Foundation
import SwiftyJSON

public protocol ResponseJSONObjectSerializable {
    init?(json: SwiftyJSON.JSON)
}