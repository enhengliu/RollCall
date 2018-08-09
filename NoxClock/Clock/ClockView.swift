//
//  ClockView.swift
//  NoxClock
//
//  Created by Andy_Liu on 2018/7/12.
//  Copyright © 2018年 Nox. All rights reserved.
//

import UIKit

class ClockView: XibView {

    @IBOutlet var hourHand: UIImageView!
    @IBOutlet var minuteHand: UIImageView!
    @IBOutlet var secondHand: UIImageView!
    private var clockOject:ClockObject!;
    @IBOutlet var dountView: UIView!
    var shape:CAShapeLayer!;
    var initAngle: CGFloat = 0;
    var endAngle: CGFloat = 0;
    var gradient:CAGradientLayer!
    var contentLayerView:UIView?;
    //MAKR :- Initialize Method
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder);
    }
    //MARK :- Life Cycle

    override func awakeFromNib() {
        
        hourHand.setAnchorPoint(CGPoint(x: 0.5, y: 0.9));
        minuteHand.setAnchorPoint(CGPoint(x: 0.5, y: 1.0));
        secondHand.setAnchorPoint(CGPoint(x: 0.5, y: 0.8));
        let clockOject:ClockObject = ClockObject();
        self.bindClockObject(clockObject: clockOject);
        super.awakeFromNib();
    }
    
    override func layoutSubviews() {

        super.layoutSubviews();
        
        if contentLayerView == nil {
            
            contentLayerView = UIView(frame: CGRect(x: 0, y: 0, width: dountView.bounds.size.width, height: dountView.bounds.size.height))
            contentLayerView?.backgroundColor = UIColor.white;
            contentLayerView?.center = CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2);
            contentLayerView?.layer.borderWidth = 13;
            contentLayerView?.layer.borderColor = UIColor.black.cgColor;
            contentLayerView?.alpha = 0.1;
            contentLayerView?.layer.cornerRadius = contentLayerView!.bounds.size.height/2;
            self.addSubview(contentLayerView!);
        }
    }
    
    //MARK :- Setup Method

    private func setDountView(_ degree:CGFloat) {
        
        self.dountView.transform = CGAffineTransform.identity;
        self.dountView.layoutIfNeeded();
        gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: CGPoint.zero, size: self.dountView.frame.size)
        gradient.colors = [UIColor.init(hex: "6FD0C1").cgColor,UIColor.init(hex: "A9D98F").cgColor,UIColor.init(hex: "8F95D9").cgColor]
        gradient.cornerRadius = self.dountView.bounds.size.height/2;
        
        shape = CAShapeLayer();
        shape.lineWidth = 26;
        shape.path = UIBezierPath(roundedRect: self.dountView.bounds, cornerRadius: self.dountView.bounds.size.height/2).cgPath;
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        self.dountView.transform = CGAffineTransform.identity.concatenating(CGAffineTransform(rotationAngle: CommonDefine.radians(degree: degree)));
        self.dountView.layer.addSublayer(gradient)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 60.0 * 60.0 * 24
        animation.fromValue = 0;
        animation.toValue = 1;
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.fillMode = kCAFillModeForwards;
        animation.isRemovedOnCompletion = false;
        shape.add(animation, forKey: "animateCircle")
    }
    
    public func setSecondHandRotation(initDegree:CGFloat) {
        
        secondHand.transform = CGAffineTransform(rotationAngle: CommonDefine.radians(degree: initDegree));
        self.setViewRotation(initDegree: initDegree, targetView: secondHand, duration: 60.0);
    }
    
    public func setMinuteHandRotation(initDegree:CGFloat) {
        
        minuteHand.transform = CGAffineTransform(rotationAngle: CommonDefine.radians(degree: initDegree));
        self.setViewRotation(initDegree: initDegree, targetView: minuteHand, duration: 60.0 * 60.0);
    }
    
    public func setHourHandRotation(initDegree:CGFloat) {
        
        hourHand.transform = CGAffineTransform(rotationAngle: CommonDefine.radians(degree: initDegree));
        self.setViewRotation(initDegree: initDegree, targetView: hourHand, duration: 60.0 * 60.0 * 24);
    }
    
    func setViewRotation(initDegree:CGFloat,targetView:UIView,duration:CGFloat) {
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation");
        rotationAnimation.fromValue = CommonDefine.radians(degree: initDegree);
        rotationAnimation.toValue = CommonDefine.radians(degree: initDegree) + CommonDefine.radians(degree: 360);
        rotationAnimation.duration = CFTimeInterval(duration);
        rotationAnimation.repeatCount = .infinity;
        targetView.layer.add(rotationAnimation, forKey: nil);
    }
}

extension ClockView {
    
    var secondAngle:CGFloat {
    
        get {
            
            let second:CGFloat = CGFloat(self.clockOject.second);
            return 360 * (second / 60.0);
        }
    }
    
    var minuteAngle:CGFloat {
        
        get {
            
            let second:CGFloat = CGFloat(self.clockOject.second);
            let minute:CGFloat = CGFloat(self.clockOject.minute);
            return 360 * ((((minute * 60.0) + second) / 60.0) / 60.0);
        }
    }
    
    var hourAngle:CGFloat {
        
        get {
            
            let second:CGFloat = CGFloat(self.clockOject.second);
            let minute:CGFloat = CGFloat(self.clockOject.minute);
            let hour:CGFloat = CGFloat(self.clockOject.hour);
            return 360 * ((((hour * 60.0 * 60.0) + (minute * 60.0) + second) / 3600.0) / 12.0);
        }
    }
    
    func getAngle(_ date:Date) -> CGFloat {
        
        let myCalendar = Calendar(identifier: Calendar.Identifier.gregorian);
        let myComponents = myCalendar.dateComponents([.hour,.minute,.second], from: date)
        let second:CGFloat = CGFloat(myComponents.second!);
        let minute:CGFloat = CGFloat(myComponents.minute!);
        var hour:CGFloat = CGFloat(myComponents.hour!);
        if hour > 12 { hour = hour - 12; }
        return 360 * ((((hour * 60.0 * 60.0) + (minute * 60.0) + second) / 3600.0) / 12.0);
    }
    
    func bindClockObject(clockObject:ClockObject) {
        
        self.clockOject = clockObject;
        self.updateUI();
    }
    
    private func updateUI () {
        
        self.setSecondHandRotation(initDegree:secondAngle);
        self.setMinuteHandRotation(initDegree:minuteAngle);
        self.setHourHandRotation(initDegree:hourAngle);
    }
    
    public func clockIn (_ date:Date) {
        
        if gradient != nil {
            
            gradient.removeFromSuperlayer();
        }
        initAngle = getAngle(date);
        self.setDountView(initAngle);
        self.removePin();
        self.addPin(initAngle)
        self.addStartFlag(initAngle)
    }
    
    public func clockout(_ date:Date) {
        
        if shape != nil {
            
            shape.removeAllAnimations();
        }
        
        if gradient != nil {
            
            gradient.removeAllAnimations();
        }
        
        endAngle = getAngle(date);
        endAngle = endAngle.truncatingRemainder(dividingBy: 360)
        let startAngle = 360 - initAngle
        shape.strokeEnd = (endAngle + startAngle)/360.0;
        self.addPin(endAngle)
        self.addEndFlag(endAngle)
    }
    
    private func addPin(_ angle:CGFloat) {
        
        let radius : CGFloat = (self.bounds.size.width + 30)/2
        let x = cos((angle - 90)°) * radius + self.bounds.size.width/2 - 8;
        let y = sin((angle - 90)°) * radius + self.bounds.size.height/2 - 10;
        let pin = UIImageView(frame: CGRect(x: x, y: y, width: 16, height: 20));
        pin.tag = 100;
        pin.transform = CGAffineTransform(rotationAngle: angle°)
        pin.image = UIImage(named: "clock_point");
        self.addSubview(pin)
        self.playPinAnimation(pin, (angle - 90));
    }
    
    private func addStartFlag(_ angle:CGFloat) {
        
        let flag:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 26, height: 26));
        flag.image = UIImage(named: "clockIn_start_flag");
        flag.setAnchorPoint(CGPoint(x: 0.5, y: 0.5));
        self.addSubview(flag);
        let flagX = cos((angle - 90)°) * (self.dountView.bounds.size.width - 13)/2 + self.dountView.bounds.size.width/2;
        let flagy = sin((angle - 90)°) * (self.dountView.bounds.size.height - 13)/2 + self.dountView.bounds.size.height/2;
        flag.frame.origin.x = flagX;
        flag.frame.origin.y = flagy;
        flag.tag = 100;
    }
    
    private func addEndFlag(_ angle:CGFloat) {
        
        let flag:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 26, height: 26));
        flag.setAnchorPoint(CGPoint(x: 0.5, y: 0.5));
        flag.image = UIImage(named: "clockIn_end_flag");
        self.addSubview(flag);
        let flagX = cos((angle - 90)°) * (self.dountView.bounds.size.width - 13)/2 + self.dountView.bounds.size.width/2;
        let flagy = sin((angle - 90)°) * (self.dountView.bounds.size.height - 13)/2 + self.dountView.bounds.size.height/2;
        flag.frame.origin.x = flagX;
        flag.frame.origin.y = flagy;
        flag.tag = 100;
    }
    
    private func removePin() {
        
        for subview in self.subviews {
            
            if subview.tag == 100 {
                
                subview.removeFromSuperview();
            }
        }
    }
    
    private func playPinAnimation(_ pin:UIView, _ angle:CGFloat) {
        
        pin.alpha = 0.0;
        UIView.animate(withDuration: 0.3, animations: {
            
            pin.alpha = 1.0;

        }) { (complete) in
            
        }
//        let radius1 : CGFloat = (self.bounds.size.width + 100)/2
//        let radius2 : CGFloat = (self.bounds.size.width + 20)/2
//        let radius3 : CGFloat = (self.bounds.size.width + 30)/2
//
//        let x = cos(angle°) * radius1 + self.bounds.size.width/2 - pin.bounds.size.width/2;
//        let y = sin(angle°) * radius1 + self.bounds.size.height/2 - pin.bounds.size.height/2;
//        let x2 = cos(CommonDefine.radians(degree: angle)) * radius2 + self.bounds.size.width/2 - pin.bounds.size.width/2;
//        let y2 = sin(CommonDefine.radians(degree: angle)) * radius2 + self.bounds.size.height/2 - pin.bounds.size.height/2;
//        let x3 = cos(CommonDefine.radians(degree: angle)) * radius3 + self.bounds.size.width/2 - pin.bounds.size.width/2;
//        let y3 = sin(CommonDefine.radians(degree: angle)) * radius3 + self.bounds.size.height/2 - pin.bounds.size.height/2;
        
//        pin.transform = pin.transform.translatedBy(x: x, y: y)
//        pin.transform = CGAffineTransform(translationX: x - pin.frame.origin.x, y: y - pin.frame.origin.y).concatenating(pin.transform)

        
//        UIView.animate(withDuration: 0.3, animations: {
//
//
//
//            pin.transform = CGAffineTransform(translationX: x2 - x, y:y2 - y).concatenating(pin.transform)
//
//
//        }) { (complete) in
//
//            UIView.animate(withDuration: 0.3, animations: {
//
//
//                pin.transform = CGAffineTransform(translationX: x3 - x2, y: y2 - ).concatenating(pin.transform)
//
//            }) { (complete) in
//
//            }
//        }
    }
}
