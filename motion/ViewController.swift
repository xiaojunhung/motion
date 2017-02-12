//
//  ViewController.swift
//  motion
//
//  Created by David on 2017/2/4.
//  Copyright © 2017年 DavidAppCoda. All rights reserved.
//

import UIKit
import CoreMotion
import CoreLocation

class ViewController: UIViewController {
    @IBOutlet weak var StartOrStopButton: UIButton!
    @IBOutlet weak var MyLabel: UILabel!
    
    @IBOutlet weak var status: UILabel!
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    let mm = CMMotionManager()
    let lm = CLLocationManager()
    var count = 10
    var AccX:Double = 0.0
    var AccY:Double = 0.0
    var AccZ:Double = 0.0
    var MagX:Double = 0.0
    var MagY:Double = 0.0
    var MagZ:Double = 0.0
    var x : Double = 0.0
    var y : Double = 0.0
    var z : Double = 0.0
    var myTimer : Timer = Timer()
    var myIphoneID : String = ""
    var currentTime : String = ""
    var mydic = [String:Any]()
    
    func updateAttitude() {
        status.text="Current Time:\(currentTime)\nid:\(myIphoneID)\nAccX:\(AccX)\nAccY:\(AccY)\nAccZ:\(AccZ)\nMagX:\(MagX)\nMagY:\(MagY)\nMagZ:\(MagZ)\nmyDic:\(mydic.count)\nx:\(x)\ny:\(y)\nz:\(z)"
        let date = NSDate()
        let calendar = NSCalendar.current
        let year = String(calendar.component(.year, from: date as Date))
        var month = String(calendar.component(.month, from: date as Date))
        var day = String(calendar.component(.day, from: date as Date))
        var hour = String(calendar.component(.hour, from: date as Date))
        var minute = String(calendar.component(.minute, from: date as Date))
        var second = String(calendar.component(.second, from: date as Date))
        
        while month.characters.count < 2 {
            month = "0"+month
        }
        while day.characters.count < 2 {
            day = "0"+day
        }
        while hour.characters.count < 2 {
            hour = "0"+hour
        }
        while minute.characters.count < 2 {
            minute = "0"+minute
        }
        while second.characters.count < 2 {
            second = "0"+second
        }
        currentTime = "\(year)-\(month)-\(day) \(hour):\(minute):\(second)"
        var myitem = [String:Any]()
        myitem["CurrentTime"] = currentTime
        myitem["X"] = x
        myitem["Y"] = y
        myitem["Z"] = z
        myitem["MagX"] = MagX
        myitem["MagY"] = MagY
        myitem["MagZ"] = MagZ
        mydic[currentTime] = myitem
        myitem = [:]
        
        
        if myitem.count == 11{
            //Post
//            let urlsrt = ""//在這裡輸入網址
//            let url = URL(string: urlsrt)
//            let str = mydic.description.replacingOccurrences(of: "[", with: "{").replacingOccurrences(of: "]", with: "}")
//            var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30)
//            request.httpBody = str.data(using: .utf8)
//            request.httpMethod = "POST"
//            
//            let config = URLSessionConfiguration.default
//            let session = URLSession(configuration: config)
//            let dataTask = session.dataTask(with: request) { (data, response, error) in
//                if let data = data {
//                    let html = String(data:data, encoding: .utf8)
//                    print(html!)
//                    mydic = [:]
//                    mydic["myID"] = myIphoneID
//                }
//            }
//            dataTask.resume()
        }
    }
    //載入事件
    //先開啟DeviceMotion並將感測器的數值放入變數
    override func viewDidLoad() {
        super.viewDidLoad()
        mm.startDeviceMotionUpdates(to: OperationQueue()) { (motion, error) in
            if let motion = motion {
                let acc = motion.userAcceleration
                self.AccX=acc.x
                self.AccY=acc.y
                self.AccZ=acc.z
                
                let rot = motion.attitude.rotationMatrix
                self.x = (acc.x*rot.m11 + acc.y*rot.m21 + acc.z*rot.m31)*9.81
                self.y = (acc.x*rot.m12 + acc.y*rot.m22 + acc.z*rot.m32)*9.81
                self.z = (acc.x*rot.m13 + acc.y*rot.m23 + acc.z*rot.m33)*9.81
            }
        }
        mm.startMagnetometerUpdates(to: OperationQueue()) { (data, error) in
            if let data = data {
                let tmp = data.magneticField
                self.MagX = tmp.x
                self.MagY = tmp.y
                self.MagZ = tmp.z
            }
        }
        myIphoneID = (UIDevice.current.identifierForVendor?.uuidString)!
        mydic["myID"] = myIphoneID
    }
    
    @IBAction func StartOrStop(_ sender: Any) {
        if StartOrStopButton.currentTitle == "Start"{
            myTimer = Timer.scheduledTimer(timeInterval: 1,
                                           target: self,
                                           selector: #selector(self.updateAttitude),
                                           userInfo: nil,
                                           repeats: true)
            StartOrStopButton.setTitle("Stop", for: .normal)
        }else{
            myTimer.invalidate()
            StartOrStopButton.setTitle("Start", for: .normal)
        }
    }
    func showmsg(msg:String){
        let alert = UIAlertController(title: "Message", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func ShowPlistOnClick(_ sender: Any) {
        
    }
        

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

