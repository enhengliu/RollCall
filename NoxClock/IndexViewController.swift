//
//  IndexViewController.swift
//  NoxClock
//
//  Created by Andy_Liu on 2018/7/12.
//  Copyright © 2018年 Nox. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import SwiftyJSON

enum IndexViewStatus {
    case ClockIn
    case ClockOut
}

class IndexViewController: BaseViewController,ClockAlertViewControllerDelegate {

    @IBOutlet var clockView: ClockView!
    @IBOutlet var clockInBtn: UIButton!
    @IBOutlet var gradientView: GradientView!
    @IBOutlet var clockInDisplayLabelView: UIView!
    @IBOutlet var clockInDisplayLabel: UILabel!
    public var status:IndexViewStatus = IndexViewStatus.ClockIn;
    // MARK: - Life Cycle

    override func viewDidLoad() {
        
        super.viewDidLoad();
        self.setupUI();
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Setup UI
    
    func setupUI() {
        
        clockInBtn.layer.masksToBounds = false
        clockInBtn.layer.shadowColor = UIColor.black.cgColor;
        clockInBtn.layer.shadowOffset = CGSize(width: 7, height: 7);
        clockInBtn.layer.shadowRadius = 19.0;
        clockInBtn.layer.shadowOpacity = 0.2;
        clockInDisplayLabelView.layer.cornerRadius = clockInDisplayLabelView.bounds.size.height/2;
        clockInDisplayLabelView.layer.masksToBounds = true;
    }
    
    // MARK: - Button Method

    @IBAction func clockInBtnOnTouchDown(_ sender: UIButton) {
        
        sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9);
    }
    
    @IBAction func clockInBtnOnTouchUpOutside(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.1,
                       animations: {
                        sender.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            sender.transform = CGAffineTransform.identity
                        }
        })
    }
    
    @IBAction func clockInBtnOnTouchUpInside(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        self.showAlertView();
        UIView.animate(withDuration: 0.1,
                       animations: {
                        sender.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            sender.transform = CGAffineTransform.identity
                        }
        })

    }
    
    // MARK: - API Method
    
    func punch() {
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        Alamofire.request("http://220.130.130.109:3211/api/employee/punch", method: .post, parameters: ["employeeId":"005","workTypeId":"0","punchContent":"Test","punchLatitude":"25.0646145","punchLongitude":"121.5120884"])
            .responseJSON { response in 
                
                MBProgressHUD.hide(for: self.view, animated: true)
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        
                        print(data)
                        let json = JSON(data);
                        let punchData = PunchData(parameter: json["data"])
                        if punchData.workTypeId == 0 {
                            
                            self.status = IndexViewStatus.ClockOut;
                            self.changeUIStatus();
                            self.clockView.removePin();
                            self.clockView.addPin();
                        }
                    }
                case .failure(_):
                    
                    print("Error message:\(response.result.error)")
                    break
                }
        }
    }
    
    func punchOut() {
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        Alamofire.request("http://220.130.130.109:3211/api/employee/punch", method: .post, parameters: ["employeeId":"005","workTypeId":"1","punchContent":"Test","punchLatitude":"25.0646145","punchLongitude":"121.5120884"])
            .responseJSON { response in
                
                MBProgressHUD.hide(for: self.view, animated: true)
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        
                        let json = JSON(data);
                        let punchData = PunchData(parameter: json["data"])
                        if punchData.workTypeId == 1 {
                            
                            self.status = IndexViewStatus.ClockIn;
                            self.changeUIStatus();
                            self.clockView.addPin();
                        }
                    }
                case .failure(_):
                    
                    print("Error message:\(response.result.error)")
                    break
                }
        }
    }

    
    // MARK: - Private Method
    
    private func changeUIStatus() {
        
        if self.status == IndexViewStatus.ClockOut {
            
            clockView.clockIn();
            clockInBtn.setImage(UIImage(named: "clock_out_btn"), for: UIControlState.normal);
            clockInDisplayLabelView.backgroundColor = UIColor.init(hex: "8119D1").alpha(0.4);
            clockInDisplayLabel.text = "下班";
        }else {
            
            clockView.clockout();
            clockInBtn.setImage(UIImage(named: "clock_in_btn"), for: UIControlState.normal);
            clockInDisplayLabelView.backgroundColor = UIColor.init(hex: "E04F4F").alpha(0.4);
            clockInDisplayLabel.text = "上班";
        }
    }
    
    private func showAlertView () {
        
        let clockAlertViewController:ClockAlertViewController = ClockAlertViewController(nibName: "ClockAlertViewController", bundle: nil);
        clockAlertViewController.status = self.status == IndexViewStatus.ClockIn ? ClockAlertViewStatus.ClockIn:ClockAlertViewStatus.ClockOut;
        clockAlertViewController.delegate = self;
        clockAlertViewController.showInViewController(self);
    }
    
    //MARK: - CutomAlertViewControllerDelegate
    
    func cutomAlertViewControllerDidSuccess(_ controller: CutomAlertViewController, cutomAlertViewStatus: ClockAlertViewStatus) {
        
        switch cutomAlertViewStatus {
        case .ClockIn:

            punch();
            break;
            
        case .ClockOut:
            
            punchOut();
            break;

        }
    }
}
