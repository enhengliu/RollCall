//
//  ClockAlertViewController.swift
//  NoxClock
//
//  Created by Andy_Liu on 2018/7/19.
//  Copyright © 2018年 Nox. All rights reserved.
//

import UIKit

class ClockAlertViewController: BaseViewController {

    @IBOutlet var mainView: UIView!
    @IBOutlet var digitalClockView: DigitalClockView!
    @IBOutlet var maskView: UIView!
    @IBOutlet var mainButton: SemiCornerButton!
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Button Method
    
    @IBAction func mainButtonOnPress(_ sender: UIButton) {
        
    }
}
