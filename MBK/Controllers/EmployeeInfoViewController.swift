//
//  EmployeeInfoViewController.swift
//  MBK
//
//  Created by Macbook Air on 12/26/2558 BE.
//  Copyright © 2558 Code-Aholic. All rights reserved.
//

import UIKit

class EmployeeInfoViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }

    @IBAction func btnSave(sender: AnyObject) {
        
        // If you want to go back to the root view controller
        navigationController?.popToRootViewControllerAnimated(true)
    }

    @IBAction func btnCancel(sender: AnyObject) {
        // If you want to go back to the previous view controller
        navigationController?.popViewControllerAnimated(true)
    }

}
