//
//  DigitalClockText.swift
//  NoxClock
//
//  Created by Andy_Liu on 2018/8/2.
//  Copyright © 2018年 Nox. All rights reserved.
//

import UIKit

class DigitalClockText: XibView {

    @IBOutlet private var hourLabel: UILabel!
    @IBOutlet private var minuteLabel: UILabel!
    @IBOutlet var upDotView: UIView!
    @IBOutlet var bottomDotView: UIView!
    
    private var _minute:Int = 0;
    private var _hour:Int = 0;
    
    public var minute:Int {
        
        get {
            
            return _minute;
        }
        
        set{
            
            _minute = newValue;
            minuteLabel.text = String(format: "%02d", newValue);
        }
    }
    
    public var hour:Int {
        
        get {
            
            return _hour;
        }
        
        set{
            
            _hour = newValue;
            hourLabel.text = String(format: "%02d", newValue);
        }
    }
    
    @IBInspectable public var color:UIColor = UIColor.white {
        
        didSet {
            
            hourLabel.textColor = color;
            minuteLabel.textColor = color;
            upDotView.backgroundColor = color;
            bottomDotView.backgroundColor = color;
        }
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews();
    }
}
