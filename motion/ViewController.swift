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
    @IBOutlet weak var attitudeX: UILabel!
    @IBOutlet weak var attitudeY: UILabel!
    @IBOutlet weak var attitudeZ: UILabel!
    @IBOutlet weak var phoneStatus: UILabel!

    let mm = CMMotionManager()
    var count = 10
    var AttX:Double = 0.0
    var AttY:Double = 0.0
    var AttZ:Double = 0.0
    
    func updateAttitude() {
        count += 1
        if count % 1 == 0 {
            if AttX > 1 {
                phoneStatus.text="直立"
            }else{
                if AttX < -1 {
                    phoneStatus.text="倒立"
                }else{
                    phoneStatus.text="平放"
                }
            }
            self.attitudeX.text="\(AttX)"
            self.attitudeY.text="\(AttY)"
            self.attitudeZ.text="\(AttZ)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mm.startDeviceMotionUpdates(to: OperationQueue()) { (motion, error) in
            if let motion = motion {
                let attitude = motion.attitude
                self.AttX=attitude.pitch
                self.AttY=attitude.roll
                self.AttZ=attitude.yaw
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(timeInterval: 1,
                                 target: self,
                                 selector: #selector(self.updateAttitude),
                                 userInfo: nil,
                                 repeats: true)
        } else {
            // Fallback on earlier versions
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

