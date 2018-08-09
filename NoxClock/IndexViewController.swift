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
    
    case ClockNone
    case ClockIn
    case ClockOut
}

class IndexViewController: BaseViewController,ClockAlertViewControllerDelegate {

    @IBOutlet var clockView: ClockView!
    @IBOutlet var clockInBtn: UIButton!
    @IBOutlet var gradientView: GradientView!
    @IBOutlet var clockInDisplayLabelView: UIView!
    @IBOutlet var clockInDisplayLabel: UILabel!
    public var status:IndexViewStatus = IndexViewStatus.ClockNone;
    @IBOutlet var clockBannerView: DigitalClockBannerView!
    @IBOutlet var moodDisplayLabel: UILabel!
    // MARK: - Life Cycle

    override func viewDidLoad() {
        
        super.viewDidLoad();
        self.setupUI();
        self.getEmployeeData();
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Setup UI
    
    func setupUI() {
        
        clockInBtn.layer.masksToBounds = false;
        clockInBtn.layer.shadowColor = UIColor.black.cgColor;
        clockInBtn.layer.shadowOffset = CGSize(width: 7, height: 7);
        clockInBtn.layer.shadowRadius = 19.0;
        clockInBtn.layer.shadowOpacity = 0.2;
        clockInDisplayLabelView.layer.cornerRadius = clockInDisplayLabelView.bounds.size.height/2;
        clockInDisplayLabelView.layer.masksToBounds = true;
        clockBannerView.setCurrentDate(Date());
        
        if let clockInDate = Member.sharedInstance.clockInTime {
            
            clockBannerView.setClockInDate(clockInDate)
        }
        
        if let clockOutDate = Member.sharedInstance.clockOutTime {
            
            clockBannerView.setClockOutDate(clockOutDate)
        }
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
    
    // MARK: - Private Method
    
    private func changeUIStatus() {
        
        switch self.status {
            
        case .ClockNone:
            clockInBtn.setImage(UIImage(named: "clock_in_btn"), for: UIControlState.normal);
            clockInDisplayLabelView.backgroundColor = UIColor.init(hex: "E04F4F").alpha(0.4);
            clockInDisplayLabel.text = "上班";
            break;
            
        case .ClockIn:
            clockView.clockIn(Member.sharedInstance.clockInTime!);
            clockInBtn.setImage(UIImage(named: "clock_out_btn"), for: UIControlState.normal);
            clockInDisplayLabelView.backgroundColor = UIColor.init(hex: "8119D1").alpha(0.4);
            clockInDisplayLabel.text = "下班";
            self.clockBannerView.setClockInDate(Member.sharedInstance.clockInTime!)
            break;
            
        case .ClockOut:
            print(Member.sharedInstance.clockOutTime!)
            clockView.clockout(Member.sharedInstance.clockOutTime!);
            clockInBtn.setImage(UIImage(named: "check_down_btn"), for: UIControlState.normal);
            clockInDisplayLabelView.backgroundColor = UIColor.init(hex: "333333").alpha(0.4);
            clockInDisplayLabel.text = "完成";
            self.clockBannerView.setClockOutDate(Member.sharedInstance.clockOutTime!)
            clockInBtn.isUserInteractionEnabled = false;
            break;
        }
    }
    
    private func showAlertView () {
        
        let clockAlertViewController:ClockAlertViewController = ClockAlertViewController(nibName: "ClockAlertViewController", bundle: nil);
        if self.status == .ClockNone {
            
            clockAlertViewController.status = .ClockIn;
        }else if self.status == .ClockIn {
            
            clockAlertViewController.status = .ClockOut;
        }else  {
            
            return;
        }
        clockAlertViewController.delegate = self;
        clockAlertViewController.showInViewController(self);
    }
    
    //MARK: - CutomAlertViewControllerDelegate
    
    func cutomAlertViewControllerDidSuccess(_ controller: CutomAlertViewController, cutomAlertViewStatus: ClockAlertViewStatus) {
        
        switch cutomAlertViewStatus {
        case .ClockIn:

            self.status = IndexViewStatus.ClockIn;
            self.changeUIStatus();
            break;
            
        case .ClockOut:
            
            self.status = IndexViewStatus.ClockOut;
            self.changeUIStatus();
            break;

        }
    }
    
    // MARK: - API Method
    
    func getEmployeeData() {
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        ClockAPIClient.shared.getEmployeeData(Member.sharedInstance.employeeId!) { response in
            
            MBProgressHUD.hide(for: self.view, animated: true)
            switch response.status {
            case .OK:
                if let data = response.value  {
                    
                    let employeeSimpleInfoData = EmployeeSimpleInfoData(parameter: data as! JSON)
                    
                    print(data)
                    if let punchInfo = employeeSimpleInfoData.getPunchInData() {
                        
                        Member.sharedInstance.clockInTime = punchInfo.getPunchDate();
                        self.status = IndexViewStatus.ClockIn;
                        self.changeUIStatus();
                    }
                    
                    if let punchInfo = employeeSimpleInfoData.getPunchOutData() {
                    
                        Member.sharedInstance.clockOutTime = punchInfo.getPunchDate();
                        self.status = IndexViewStatus.ClockOut;
                        self.changeUIStatus();
                    }
                }
                break;
                
            default:
                self.showToast("取得個人資料失敗")
                break;
            }
        }
    }
}
