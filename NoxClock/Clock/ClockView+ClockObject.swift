//
//  ClockView+ClockObject.swift
//  NoxClock
//
//  Created by Andy_Liu on 2018/7/12.
//  Copyright © 2018年 Nox. All rights reserved.
//

//import Foundation
//import ObjectiveC
//
//extension ClockView {
//    
//    static var ClockObjectKey:String = "ClockObjectKey"
//
//    var clockOject:ClockObject {
//        get {
//            return objc_getAssociatedObject(self, &ClockView.ClockObjectKey) as! ClockObject;
//        }
//        set { objc_setAssociatedObject(self, &ClockView.ClockObjectKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
//    }
//    
//    func bindClockObject(clockObject:ClockObject) {
//        
//        self.clockOject = clockObject;
//    }
//    
//    private func updateUI () {
//        
//        let hour:CGFloat = CGFloat(self.clockOject.hour);
//        let minute:CGFloat = CGFloat(self.clockOject.minute);
//        let second:CGFloat = CGFloat(self.clockOject.second);
//
//        let hourAngle:CGFloat = 360 * ((((hour * 60.0 * 60.0) + (minute * 60.0) + second) / 3600.0) / 12.0);
//        let minuteAngle:CGFloat = 360 * ((((minute * 60.0) + second) / 60.0) / 60.0);
//        let secondAngle:CGFloat = 360 * (second / 60.0);
//        self.setSecondHandRotation(initDegree:secondAngle);
//    }
//}
