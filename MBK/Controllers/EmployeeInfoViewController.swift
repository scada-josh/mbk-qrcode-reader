//
//  EmployeeInfoViewController.swift
//  MBK
//
//  Created by Macbook Air on 12/26/2558 BE.
//  Copyright © 2558 Code-Aholic. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class EmployeeInfoViewController: UIViewController {

    @IBOutlet weak var lblUserID: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserPosition: UILabel!
    @IBOutlet weak var lblUserDivision: UILabel!
    @IBOutlet weak var lblUserOrg: UILabel!
    
    var myUserInfo = [UserInfo]()
    var myQRcode: String!
    var myEventID: String!
    
    
    override func viewDidAppear(animated: Bool) {
        printGetUserByID(myQRcode)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }

    @IBAction func btnSave(sender: AnyObject) {
        
//        Alamofire.request(myRouter.UpdateAttendeeStatus())
//            .responseString { response in
//                if let receivedString = response.result.value {
//                    print(receivedString)
//                }
//        }
        
        Alamofire.request(.POST, "http://169.254.65.182/mbk/build/src/api/eventManager/updateAttendeeStatus/",
            parameters: ["event_id": self.myEventID, "user_id": self.myQRcode])
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
            }
        
        
        
        // If you want to go back to the root view controller
        navigationController?.popToRootViewControllerAnimated(true)
    }

    @IBAction func btnCancel(sender: AnyObject) {
        // If you want to go back to the previous view controller
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    func printGetUserByID(paramUserID: String) -> Void {
        
        //        Alamofire.request(myRouter.GetUserByID("00000002"))
        //            .responseString { response in
        //            if let receivedString = response.result.value {
        //                print(receivedString)
        //            }
        //        }
        
        APIManager.sharedInstance.getUserByID(paramUserID) { result in
            
            guard result.error == nil else {
            print(result.error)
            // TODO: display error
            return
            }
            
            
            if let fetchMyUserInfo = result.value {
                self.myUserInfo = fetchMyUserInfo
                print(self.myUserInfo)
                print(self.myUserInfo[0].user_id!)
                print(self.myUserInfo[0].user_name!)
                
                self.lblUserID.text = self.myUserInfo[0].user_id!
                self.lblUserName.text = self.myUserInfo[0].user_name!
                self.lblUserPosition.text = self.myUserInfo[0].user_position!
                self.lblUserDivision.text = self.myUserInfo[0].user_division!
                self.lblUserOrg.text = self.myUserInfo[0].user_org!
                
                print(self.myEventID)
                
            }
        }
        
    }

}
