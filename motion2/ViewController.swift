//
//  ViewController.swift
//  motion2
//
//  Created by 蕭俊鴻 on 2017/2/22.
//  Copyright © 2017年 蕭俊鴻. All rights reserved.
//

import UIKit
import CoreLocation
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet weak var btn: UIButton!
    
    let mm = CMMotionManager()
    let formatter = DateFormatter()
    var mydata = [String:Any]()
    var action:Int=0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var af:Double=0
        var aw:Double=0
        var count:Int=0
        
        
        formatter.dateFormat = "yyyy-M-d H:m:s"
        
        // Do any additional setup after loading the view, typically from a nib.
        mm.startDeviceMotionUpdates(to:OperationQueue()){ (motion, error) in
            if let motion = motion{
                let currentDate=NSDate()
                let acc = motion.userAcceleration
                let gyro = motion.rotationRate
                let att = motion.attitude
                var attYaw:CGFloat=0
                var attRoll:CGFloat=0
                var attPitch:CGFloat=0
                let d=self.formatter.string(from: currentDate as Date)
                var mylist=[String:Any]()
                
                attYaw=CGFloat(-att.yaw * 2 / M_PI) * 90
                attRoll=CGFloat(-att.roll * 2 / M_PI) * 90
                attPitch=CGFloat(-att.pitch * 2 / M_PI) * 90
                af=abs(sqrt(pow(acc.x,2)+pow(acc.y,2)+pow(acc.z,2)))
                aw=abs(sqrt(pow(gyro.x,2)+pow(gyro.y,2)+pow(gyro.z,2)))
                mylist["Time"]=d
                mylist["attYaw"]=attYaw
                mylist["attRoll"]=attRoll
                mylist["attPitch"]=attPitch
                mylist["af"]=af
                mylist["aw"]=aw
                mylist["action"]=self.action
                self.mydata[String(count)]=mylist
                count += 1
                if(self.mydata.count>=100){
                    count=0
                    self.PostData()
                }
            }
        }
    }
    @IBAction func btnAction(_ sender: Any) {
        if(btn.currentTitle=="靜止"){
            action=0;
            btn.setTitle("移動", for: .normal)
        }else{
            if(btn.currentTitle=="移動"){
                action=1;
                btn.setTitle("靜止", for: .normal)
            }
        }
    }
    
    func PostData(){
        let urlstr="http://120.119.80.94:9487/"
        let url = URL(string: urlstr)
        let jsonData = try? JSONSerialization.data(withJSONObject: mydata)
        var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30)
        //request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody=jsonData
        request.httpMethod = "POST"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let dataTask = session.dataTask(with: request){(data, response, error) in
            if let data = data{
                self.mydata=[:]
            }
        }
        dataTask.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

