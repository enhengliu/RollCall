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
    
    private var _second:Int = 0;
    private var _minute:Int = 0;
    private var _hour:Int = 0;
    private var _hiddenPlaceholder:Bool = false;
    private var _hiddenDisplayName:Bool = false;
    private var _digitalFontSize:CGFloat = 0;
    private var _edgeInsets:UIEdgeInsets = UIEdgeInsets.zero;


    public var second:Int {
        
        get {
            
            return _second;
        }
        
        set{
            
            _second = newValue;
            secondNumberLabel.text = String(format: "%02d", newValue);
        }
    }
    
    public var minute:Int {
        
        get {
            
            return _minute;
        }
        
        set{
            
            _minute = newValue;
            minuteNumberLabel.text = String(format: "%02d", newValue);
        }
    }
    
    public var hour:Int {
        
        get {
            
            return _hour;
        }
        
        set{
            
            _hour = newValue;
            hourNumberLabel.text = String(format: "%02d", newValue);
        }
    }
    
    public var hiddenPlaceholder:Bool {
        
        get {
            
            return _hiddenPlaceholder;
        }
        
        set{
            
            _hiddenPlaceholder = newValue;
            placeholderView.isHidden = newValue;
        }
    }
    
    public var hiddenDisplayName:Bool {
        
        get {
            
            return _hiddenDisplayName;
        }
        
        set{
            
            _hiddenDisplayName = newValue;
            secondNameLabel.isHidden = newValue;
            minuteNameLabel.isHidden = newValue;
            hourNameLabel.isHidden = newValue;
        }
    }
    
    public var digitalFontSize:CGFloat {
        
        get {
            
            return _digitalFontSize;
        }
        
        set{
            
            _digitalFontSize = newValue;
            secondNumberLabel.font.withSize(newValue);
            minuteNumberLabel.font.withSize(newValue);
            hourNumberLabel.font.withSize(newValue);
        }
    }
    
    public var edgeInsets:UIEdgeInsets {
        
        get {
            
            return _edgeInsets;
        }
        
        set{

            _edgeInsets = newValue;
            bottomConstraint.constant = newValue.bottom;
            topConstraint.constant = newValue.top;
            leadingConstraint.constant = newValue.left;
            trailingConstraint.constant = newValue.right;
        }
    }
}
