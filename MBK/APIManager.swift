//
//  APIManager.swift
//  MBK
//
//  Created by Macbook Air on 12/22/2558 BE.
//  Copyright © 2558 Code-Aholic. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIManager {
    static let sharedInstance = APIManager()
    
    func printPublicGists() -> Void { // TODO: implement
        Alamofire.request(myRouter.GetPublic())
        .responseString { response in
            if let receivedString = response.result.value {
                print(receivedString)
            }
        }
    }
    
    
    func getPublicGists(completionHandler: (Result<[Gist], NSError>) -> Void) {
            Alamofire.request(myRouter.GetPublic())
                .responseArray { (response:Response<[Gist], NSError>) in
                    completionHandler(response.result)
            }
    }
    
    func getEvents(completionHandler: (Result<[Event], NSError>) -> Void) {
        Alamofire.request(myRouter.GetEvent())
            .responseArray { (response:Response<[Event], NSError>) in
                completionHandler(response.result)
        }
    }
    
    
}