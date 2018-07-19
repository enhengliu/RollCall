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
    @IBOutlet var dountView: Dount!
    @IBOutlet var testView: UIView!
    let shape = CAShapeLayer();
    var initAngle: CGFloat = 0;
    var endAngle: CGFloat = 0;
    override func awakeFromNib() {
        
        hourHand.setAnchorPoint(CGPoint(x: 0.5, y: 0.9));
        minuteHand.setAnchorPoint(CGPoint(x: 0.5, y: 1.0));
        secondHand.setAnchorPoint(CGPoint(x: 0.5, y: 0.8));
        let clockOject:ClockObject = ClockObject();
        self.bindClockObject(clockObject: clockOject);
        super.awakeFromNib();
    }
    
    private func setDountView(_ degree:CGFloat) {
        
        self.testView.layoutIfNeeded();
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: CGPoint.zero, size: self.testView.frame.size)
        gradient.colors = [UIColor.init(hex: "6FD0C1").cgColor,UIColor.init(hex: "A9D98F").cgColor,UIColor.init(hex: "8F95D9").cgColor]
        gradient.cornerRadius = self.testView.bounds.size.height/2;
        
        shape.lineWidth = 15
        shape.path = UIBezierPath(roundedRect: self.testView.bounds, cornerRadius: self.testView.bounds.size.height/2).cgPath;
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        self.testView.transform = CGAffineTransform(rotationAngle: CommonDefine.radians(degree: degree));
        self.testView.layer.addSublayer(gradient)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 60.0
        animation.fromValue = 0;
        animation.toValue = 1;
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        shape.strokeEnd = 1.0
        animation.fillMode = kCAFillModeForwards;
        animation.isRemovedOnCompletion = true;
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
    
    func bindClockObject(clockObject:ClockObject) {
        
        self.clockOject = clockObject;
        self.updateUI();
    }
    
    private func updateUI () {
        
        let hour:CGFloat = CGFloat(self.clockOject.hour);
        let minute:CGFloat = CGFloat(self.clockOject.minute);
        let second:CGFloat = CGFloat(self.clockOject.second);
        let hourAngle:CGFloat = 360 * ((((hour * 60.0 * 60.0) + (minute * 60.0) + second) / 3600.0) / 12.0);
        let minuteAngle:CGFloat = 360 * ((((minute * 60.0) + second) / 60.0) / 60.0);
        let secondAngle:CGFloat = 360 * (second / 60.0);
        self.setSecondHandRotation(initDegree:secondAngle);
        self.setMinuteHandRotation(initDegree:minuteAngle);
        self.setHourHandRotation(initDegree:hourAngle);
    }
    
    public func clockIn () {
        
        let secondAngle:CGFloat = 360 * (CGFloat(self.clockOject.second) / 60.0);
        initAngle = secondAngle;
        self.setDountView(secondAngle);
    }
    
    public func clockout () {
        
        shape.removeAnimation(forKey: "animateCircle");
        let secondAngle:CGFloat = 360 * (CGFloat(self.clockOject.second) / 60.0);
        var temp:CGFloat  = initAngle-secondAngle;
        shape.strokeEnd = (endAngle/360)°
    }

}
