//
//  myRouter.swift
//  MBK
//
//  Created by Macbook Air on 12/22/2558 BE.
//  Copyright © 2558 Code-Aholic. All rights reserved.
//

import Foundation
import Alamofire

enum myRouter: URLRequestConvertible {
    
    static let baseURLString:String = "http://169.254.65.182/mbk/build/src/api"
    //static let baseURLString:String = "https://api.github.com"
    
    case GetEvent()             // GET http://localhost/mbk/build/src/api/eventManager/listEventForMobile/
    case GetUserByID(String)    // GET http://localhost/mbk/build/src/api/userManager/getUserByID/:userID
    case UpdateAttendeeStatus() // POST http://localhost/mbk/build/src/api/eventManager/updateAttendeeStatus/
    case GetPublic()            // GET https://api.github.com/gists/public
    
    var URLRequest: NSMutableURLRequest {
        
        var method: Alamofire.Method {
            switch self {
            case .GetEvent:
                return .GET
            case .GetUserByID:
                return .GET
            case .UpdateAttendeeStatus:
                return .POST
            case .GetPublic:
                return .GET
            }
        }
        
        
        let result: (path: String, parameters: [String: AnyObject]?) = {
            switch self {
            case .GetEvent:
                return ("/eventManager/listEventForMobile/", nil)
            case .GetUserByID(let userID):
                return ("/userManager/getUserByID/\(userID)", nil)
            case .UpdateAttendeeStatus:
                return ("/eventManager/updateAttendeeStatus/", nil)
            case .GetPublic:
                return ("/gists/public", nil)
            }
        }()
        
        
        let URL = NSURL(string: myRouter.baseURLString)!
        let URLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(result.path))
        
        
        let encoding = Alamofire.ParameterEncoding.JSON
        let (encodedRequest, _) = encoding.encode(URLRequest, parameters: result.parameters)
        
        encodedRequest.HTTPMethod = method.rawValue
        
        return encodedRequest
    }
    
}