//
//  IndexViewController.swift
//  NoxClock
//
//  Created by Andy_Liu on 2018/7/12.
//  Copyright © 2018年 Nox. All rights reserved.
//

import UIKit

class IndexViewController: BaseViewController {

    @IBOutlet var clockView: ClockView!
    @IBOutlet var clockInBtn: UIButton!
    @IBOutlet var gradientView: UIView!
    @IBOutlet var clockInDisplayLabelView: UIView!
    @IBOutlet var clockInDisplayLabel: UILabel!
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
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0);
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.9);
        gradientLayer.colors = [UIColor.init(hex: "DE5858").cgColor, UIColor.init(hex: "E8BA81").cgColor]
        self.gradientView.layer.addSublayer(gradientLayer)
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
        self.changeUIStatus();
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
        
        if clockInBtn.isSelected {
            
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
}
