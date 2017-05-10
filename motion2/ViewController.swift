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
    var mydata = [Int:Any]()
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
                let d=self.formatter.string(from: currentDate as Date)
                var mylist=[String:Any]()
                
                af=abs(sqrt(pow(acc.x,2)+pow(acc.y,2)+pow(acc.z,2)))
                aw=abs(sqrt(pow(gyro.x,2)+pow(gyro.y,2)+pow(gyro.z,2)))
                print("af:\(af)\naw:\(aw)\ntime:\(d)")
                mylist["Time"]=d
                mylist["af"]=af
                mylist["aw"]=aw
                mylist["action"]=self.action
                self.mydata[count]=mylist
                count += 1
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

