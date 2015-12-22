//
//  ViewController.swift
//  MBK
//
//  Created by Macbook Air on 12/21/2558 BE.
//  Copyright © 2558 Code-Aholic. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var gists = [Gist]()
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        
        
//        Alamofire.request(.GET, "https://httpbin.org/get", parameters: ["foo": "bar"])
//            .responseJSON { response in
//                print(response.request)  // original URL request
//                print(response.response) // URL response
//                print(response.data)     // server data
//                print(response.result)   // result of response serialization
//                
//                if let JSON = response.result.value {
//                    print("JSON: \(JSON)")
//                }
//        }
        
        
        
        
        
        
//        let postEndpoint: String = "http://swapi.co/api/people/1/"
//        Alamofire.request(.GET, postEndpoint)
//            .responseJSON { response in
//            
//            guard response.result.error == nil else {
//                // got an error in getting the data, need to handle it
//                print("error calling GET on /posts/1")
//                print(response.result.error!)
//                return
//            }
//            
//            
////            if let JSON = response.result.value {
////                print("JSON: \(JSON)")
////            }
//            
//            
//            if let value: AnyObject = response.result.value {
//                // handle the results as JSON, without a bunch of nested if loops 
//                let post = JSON(value)
//                // now we have the results, let's just print them
//                // though a table view would definitely be better UI:
//                print("The post is: " + post.description)
//                
//                if let eye_color = post["eye_color"].string {
//                    // to access a field:
//                    print("The eye_color is: " + eye_color)
//                } else {
//                    print("error parsing /posts/1")
//                }
//            }
//            
//        }
        
    }

    @IBAction func btnGetListEvents(sender: AnyObject) {
                    
            let postEndpoint: String = "http://169.254.122.130/mbk/build/src/api/eventManager/listEvent/"
            Alamofire.request(.POST, postEndpoint)
            .responseJSON { response in
                    
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling GET on /posts/1")
                    print(response.result.error!)
                    return
                }
                
                if let value: AnyObject = response.result.value {
                        // handle the results as JSON, without a bunch of nested if loops
                        let post = JSON(value)
                        // now we have the results, let's just print them
                        // though a table view would definitely be better UI:
                        print("The post is: " + post.description)
                        
                        if let rows = post["result"].string {
                            // to access a field:
                            print("The event_name_th is: " + rows)
                        } else {
                            print("error parsing /posts/1")
                        }
                }
                    
            }
    }
    
    
    func loadGists() {
        //APIManager.sharedInstance.printPublicGists()
        
        APIManager.sharedInstance.getPublicGists() { result in
                
                guard result.error == nil else {
                    print(result.error)
                    // TODO: display error
                    return
                }
                
                if let fetchedGists = result.value {
                    self.gists = fetchedGists
                }
                self.myTableView.reloadData()
        }
    }
    
    
    func loadGists_tmp() {
            let gist1 = Gist()
                gist1.description = "The first gist"
                gist1.ownerLogin = "gist1Owner"
                        
            let gist2 = Gist()
                gist2.description = "The second gist"
                gist2.ownerLogin = "gist2Owner"
                        
            let gist3 = Gist()
                gist3.description = "The third gist"
                gist3.ownerLogin = "gist3Owner"
            
            gists = [gist1, gist2, gist3]
            // Tell the table view to reload
            self.myTableView.reloadData()
    }
    
    
    override func viewDidAppear(animated: Bool) {
                super.viewDidAppear(animated)
                loadGists()
    }
    
    
    // MARK: - Table View
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return gists.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = myTableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
            let gist = gists[indexPath.row]
            cell.textLabel!.text = gist.description
            cell.detailTextLabel!.text = gist.ownerLogin
                    
            // TODO: set cell.imageView to display image at gist.ownerAvatarURL
            return cell
    }
    
    
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
                    
            if segue.identifier == "showDetail" {
                        print("Hello world");
            }
    }


}

