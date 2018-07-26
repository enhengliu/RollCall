//
//  ClockAlertViewController.swift
//  NoxClock
//
//  Created by Andy_Liu on 2018/7/19.
//  Copyright © 2018年 Nox. All rights reserved.
//

import UIKit

enum ClockAlertViewStatus {
    case ClockIn
    case ClockOut
}

protocol ClockAlertViewControllerDelegate:class {
    
    func cutomAlertViewControllerDidSuccess(_ controller: CutomAlertViewController, cutomAlertViewStatus: ClockAlertViewStatus)
}

class ClockAlertViewController: CutomAlertViewController {

    @IBOutlet var mainView: UIView!
    @IBOutlet var digitalClockView: DigitalClockView!
    @IBOutlet var mainButton: SemiCornerButton!
    @IBOutlet var blackMaskView: UIView!
    @IBOutlet var clockStatusLabel: UILabel!
    @IBOutlet var defaultView: UIView!
    @IBOutlet var resultView: UIView!
    private var clockOject:ClockObject = ClockObject();
    private var timer:Timer!;
    public var status:ClockAlertViewStatus!;
    public weak var delegate:ClockAlertViewControllerDelegate?;
    
    // MARK: - Initialize Method
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad();
        self.setupUI();
        self.setupTimer();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated);
        self.updateUI();
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated);
        self.removeTimer();
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Setup Method
    
    func setupUI() {
        
        self.maskView = blackMaskView;
        self.contentView = mainView;
        self.mainView.layer.cornerRadius = 10.0;
        self.mainView.clipsToBounds = true;
        digitalClockView.hiddenPlaceholder = true;
        digitalClockView.digitalFontSize = 64;
        self.updateClock();
    }
    
    func updateUI()  {
        self.clockStatusLabel.text = self.status == ClockAlertViewStatus.ClockIn ?"上班":"下班";
        if self.status == ClockAlertViewStatus.ClockIn {
            
            self.mainButton.setBackgroundColor(color: UIColor(hex: "E04F4F"), forState: UIControlState.normal)
        }else {
            
            self.mainButton.setBackgroundColor(color: UIColor(hex: "8119D1"), forState: UIControlState.normal)
        }
    }
    
    func setupTimer() {
        
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateClock), userInfo: nil, repeats: true);
    }
    
    func removeTimer() {
        
        if self.timer != nil {
            
            self.timer.invalidate();
            self.timer = nil;
        }
    }
    
    //MARK: - Button Method
    
    @IBAction func mainButtonOnPress(_ sender: UIButton) {
     
        self.showResultView();
        self.hideDefaultView();
    }
    
    //MARK: - Timer Method
    
    @objc func updateClock() {
        
        digitalClockView.hour = clockOject.hour;
        digitalClockView.minute = clockOject.minute;
        digitalClockView.second = clockOject.second;
    }
    
    // MARK: - Private Method
    
    private func showResultView() {
        
        self.resultView.alpha = 0.0;
        self.resultView.isHidden = false;
        
        UIView.animate(withDuration: 0.3, animations: {
            
            self.resultView.alpha = 1.0;

        }) { (complete) in
            
            self.removeTimer();
            self.delegate?.cutomAlertViewControllerDidSuccess(self, cutomAlertViewStatus: self.status);
            Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(self.hide), userInfo: nil, repeats: false);
        }
    }
    
    private func hideDefaultView() {
        
        UIView.animate(withDuration: 0.3, animations: {
            
            self.defaultView.alpha = 0.0;

        }) { (complete) in
            
            self.defaultView.isHidden = true;
        }
    }
}
