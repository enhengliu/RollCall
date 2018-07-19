//
//  DigitalClockView.swift
//  NoxClock
//
//  Created by Andy_Liu on 2018/7/19.
//  Copyright © 2018年 Nox. All rights reserved.
//

import UIKit

class DigitalClockView: XibView {

    @IBOutlet private var hourNumberLabel: UILabel!
    @IBOutlet private var minuteNumberLabel: UILabel!
    @IBOutlet private var secondNumberLabel: UILabel!
    @IBOutlet private var firstDotView: UIStackView!
    @IBOutlet private var secondDotView: UIStackView!
    @IBOutlet private var hourNameLabel: UILabel!
    @IBOutlet private var minuteNameLabel: UILabel!
    @IBOutlet private var secondNameLabel: UILabel!
    @IBOutlet private var bottomConstraint: NSLayoutConstraint!
    @IBOutlet private var trailingConstraint: NSLayoutConstraint!
    @IBOutlet private var leadingConstraint: NSLayoutConstraint!
    @IBOutlet private var topConstraint: NSLayoutConstraint!
    @IBOutlet private var placeholderView: UIStackView!
    
    public var second:Int {
        
        get {
            
            return self.second;
        }
        
        set{
            
            self.second = newValue;
            secondNumberLabel.text = String(format: "%02d", newValue);
        }
    }
    
    public var minute:Int {
        
        get {
            
            return self.minute;
        }
        
        set{
            
            self.minute = newValue;
            minuteNumberLabel.text = String(format: "%02d", newValue);
        }
    }
    
    public var hour:Int {
        
        get {
            
            return self.hour;
        }
        
        set{
            
            self.hour = newValue;
            hourNumberLabel.text = String(format: "%02d", newValue);
        }
    }
    
    public var hiddenPlaceholder:Bool {
        
        get {
            
            return self.hiddenPlaceholder;
        }
        
        set{
            
            self.hiddenPlaceholder = newValue;
            placeholderView.isHidden = newValue;
        }
    }
    
    public var hiddenDisplayName:Bool {
        
        get {
            
            return self.hiddenDisplayName;
        }
        
        set{
            
            self.hiddenDisplayName = newValue;
            secondNameLabel.isHidden = newValue;
            minuteNameLabel.isHidden = newValue;
            hourNameLabel.isHidden = newValue;
        }
    }
    
    public var digitalFont:CGFloat {
        
        get {
            
            return self.digitalFont;
        }
        
        set{
            
            self.digitalFont = newValue;
            secondNumberLabel.font.withSize(newValue);
            minuteNumberLabel.font.withSize(newValue);
            hourNumberLabel.font.withSize(newValue);
        }
    }
    
    public var edgeInsets:UIEdgeInsets {
        
        get {
            
            return self.edgeInsets;
        }
        
        set{

            self.edgeInsets = newValue;
            bottomConstraint.constant = newValue.bottom;
            topConstraint.constant = newValue.top;
            leadingConstraint.constant = newValue.left;
            trailingConstraint.constant = newValue.right;
        }
    }
}
