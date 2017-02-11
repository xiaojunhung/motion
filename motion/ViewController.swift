//
//  ViewController.swift
//  motion
//
//  Created by David on 2017/2/4.
//  Copyright © 2017年 DavidAppCoda. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    @IBOutlet weak var StartOrStopButton: UIButton!
    @IBOutlet weak var MyLabel: UILabel!
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    let mm = CMMotionManager()
    var count = 10
    var AccX:Double = 0.0
    var AccY:Double = 0.0
    var AccZ:Double = 0.0
    var AttX:Double = 0.0
    var AttY:Double = 0.0
    var AttZ:Double = 0.0
    var mySpeed : Double = 0.0
    var myTimer : Timer = Timer()
    
    func updateAttitude() {
        if AttY > 80 && AttY < 90 {
            mySpeed = mySpeed+AccZ
        }
        let sp = NSString(format:"%.2f",mySpeed)
        MyLabel.text = sp as String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mm.startDeviceMotionUpdates(to: OperationQueue()) { (motion, error) in
            if let motion = motion {
                let acceleration = motion.userAcceleration
                self.AccX=acceleration.x
                self.AccY=acceleration.y
                self.AccZ=acceleration.z
                
                let attitude = motion.attitude
                self.AttX=attitude.pitch
                self.AttY=attitude.roll
                self.AttZ=attitude.yaw
            }
        }
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
    
    @IBAction func ShowPlistOnClick(_ sender: Any) {
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

