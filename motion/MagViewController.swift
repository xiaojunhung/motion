//
//  MagViewController.swift
//  motion
//
//  Created by 蕭俊鴻 on 12/02/2017.
//  Copyright © 2017 DavidAppCoda. All rights reserved.
//

import UIKit
import CoreMotion

class MagViewController: UIViewController {
    
    @IBOutlet weak var TFXAxis: UITextField!
    @IBOutlet weak var TFYAxis: UITextField!
    @IBOutlet weak var LBMag: UILabel!
    
    let mm = CMMotionManager()
    var mytimer = Timer()
    var x : Double = 0.0
    var y : Double = 0.0
    var Magx :Double = 0.0
    var Magy :Double = 0.0
    var Magz :Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mm.startMagnetometerUpdates(to: OperationQueue()) { (data, error) in
            if let data = data {
                let tmp = data.magneticField
                self.Magx = tmp.x
                self.Magy = tmp.y
                self.Magz = tmp.z
            }
        }
        mytimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateLB), userInfo: nil, repeats: true)
    }
    
    func updateLB(){
        LBMag.text = "X:\(Magx)\nY:\(Magy)\nZ:\(Magz)"
    }
    
    @IBAction func BTNsubmit(_ sender: Any) {
        if (TFXAxis.text?.isEmpty)! || (TFYAxis.text?.isEmpty)! {
            showmsg(msg: "請輸入X與Y軸座標")
            return
        }
        x = Double(TFXAxis.text!)!
        y = Double(TFYAxis.text!)!
        var mydic = [String:Any]()
        mydic["Magx"] = Magx
        mydic["Magy"] = Magy
        mydic["Magz"] = Magz
        mydic["X"] = x
        mydic["Y"] = y
        //Post
        let urlsrt = "http://192.168.2.189/pedtac/php/insertMag.php"//在這裡輸入網址
        let url = URL(string: urlsrt)
        let jsonData = try? JSONSerialization.data(withJSONObject: mydic)
        var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
        if let data = data {
                self.showmsg(msg: "已送出")
                let html = String(data:data, encoding: .utf8)
                print(html!)
            }
        }
        dataTask.resume()
    }
    
    func showmsg(msg : String) {
        let alert = UIAlertController(title: "訊息視窗", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnClearTF(_ sender: Any) {
        TFXAxis.text = ""
        TFYAxis.text = ""
    }

    @IBAction func onTFXExit(_ sender: Any) {
        (sender as AnyObject).resignFirstResponder()
    }
    @IBAction func onTFYExit(_ sender: Any) {
        (sender as AnyObject).resignFirstResponder()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
