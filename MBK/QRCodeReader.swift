//
//  QRCodeReader.swift
//  MBK
//
//  Created by Macbook Air on 12/22/2558 BE.
//  Copyright © 2558 Code-Aholic. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeReader: UIViewController, AVCaptureMetadataOutputObjectsDelegate, AVAudioPlayerDelegate {

    @IBOutlet weak var lblShowResult: UILabel!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var lblEventName: UILabel!
    
    @IBOutlet weak var lblLocationName: UILabel!
    
    @IBOutlet weak var outletScanQRCode: UIButton!
    @IBOutlet weak var imageDecoration001: UIView!
    
    
    var objCaptureSession:AVCaptureSession?
    var objCaptureVideoPreviewLayer:AVCaptureVideoPreviewLayer?
    var vwQRCode:UIView?
    
    var myEventName:String!
    var myLocationName:String!
    
    var audioPlayer: AVAudioPlayer!
    
    override func viewWillAppear(animated: Bool) {
        self.lblEventName.text = myEventName
        self.lblLocationName.text = myLocationName
        
        if((objCaptureSession) != nil) {
            objCaptureSession?.startRunning()
        }
        
        self.loadBeepSound()
    }
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.configureVideoCapture()
        self.addVideoPreviewLayer()
        self.initializeQRView()
        
        self.loadBeepSound()
        
        /*******************************************/
        /******** View Count Booth Visitor *********/
        /*******************************************/
        // border radius
        self.myView.layer.cornerRadius = 10.0
        
        // border
        self.myView.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.myView.layer.borderWidth = 1.5
        
        // drop shadow
        self.myView.layer.shadowColor = UIColor.grayColor().CGColor
        self.myView.layer.shadowOpacity = 0.8
        self.myView.layer.shadowRadius = 3.0
        self.myView.layer.shadowOffset = CGSizeMake(2.0, 2.0)
        
        self.myView.layer.masksToBounds = true
        
        
        
        self.imageDecoration001.layer.zPosition = CGFloat(MAXFLOAT)+100;
        self.outletScanQRCode.layer.zPosition = CGFloat(MAXFLOAT)+101;
        
    }

    func configureVideoCapture() {
        let objCaptureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        var error:NSError?
        let objCaptureDeviceInput: AnyObject!
        do {
            objCaptureDeviceInput = try AVCaptureDeviceInput(device: objCaptureDevice) as AVCaptureDeviceInput
            
        } catch let error1 as NSError {
            error = error1
            objCaptureDeviceInput = nil
        }
        if (error != nil) {
            let alertView:UIAlertView = UIAlertView(title: "Device Error", message:"Device not Supported for this Application", delegate: nil, cancelButtonTitle: "Ok Done")
            alertView.show()
            return
        }
        objCaptureSession = AVCaptureSession()
        objCaptureSession?.addInput(objCaptureDeviceInput as! AVCaptureInput)
        let objCaptureMetadataOutput = AVCaptureMetadataOutput()
        objCaptureSession?.addOutput(objCaptureMetadataOutput)
        objCaptureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        objCaptureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
    }
    
    func addVideoPreviewLayer()
    {
        objCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: objCaptureSession)
        objCaptureVideoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        objCaptureVideoPreviewLayer?.frame = self.myView.layer.bounds
        self.myView.layer.addSublayer(objCaptureVideoPreviewLayer!)
        objCaptureSession?.startRunning()
    }
    
    func initializeQRView() {
        vwQRCode = UIView()
        vwQRCode?.layer.borderColor = UIColor.redColor().CGColor
        vwQRCode?.layer.borderWidth = 5
        self.myView.addSubview(vwQRCode!)
        self.myView.bringSubviewToFront(vwQRCode!)
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        if metadataObjects == nil || metadataObjects.count == 0 {
            vwQRCode?.frame = CGRectZero
            lblShowResult.text = "NO QRCode text detacted"
            return
        }
        let objMetadataMachineReadableCodeObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if objMetadataMachineReadableCodeObject.type == AVMetadataObjectTypeQRCode {
            let objBarCode = objCaptureVideoPreviewLayer?.transformedMetadataObjectForMetadataObject(objMetadataMachineReadableCodeObject as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            vwQRCode?.frame = objBarCode.bounds;
            if objMetadataMachineReadableCodeObject.stringValue != nil {
                lblShowResult.text = objMetadataMachineReadableCodeObject.stringValue
                
                objCaptureSession?.stopRunning()
                
                if ((audioPlayer) != nil) {
                    audioPlayer.play()
                }
                
            }
        }
    }
    
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showEmployeeInfo" {
            
            if let destination = segue.destinationViewController as? EmployeeInfoViewController {
                    print("Hello...")
            }
        }
    }
    
    func loadBeepSound(){
        let soundURL: NSURL = NSBundle.mainBundle().URLForResource("beep", withExtension: "mp3")!
        audioPlayer = try! AVAudioPlayer(contentsOfURL: soundURL)
        audioPlayer.delegate = self
        // audioPlayer.play()
        audioPlayer.prepareToPlay()
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        audioPlayer = nil
        performSegueWithIdentifier("showEmployeeInfo", sender: self)
    }
    
    @IBAction func btnScanQRCode(sender: AnyObject) {
    }

}
