//
//  CommonDefine.swift
//  NoxClock
//
//  Created by Andy_Liu on 2018/7/12.
//  Copyright © 2018年 Nox. All rights reserved.
//

import UIKit

class CommonDefine: NSObject {

    static public func radians(degree:CGFloat) -> CGFloat {
    
        return degree * CGFloat.pi / 180;
    }
    
    static public var FontPingFangTCRegular:String = "PingFangTC-Regular"
    static public var FontPingFangTCMedium:String = "PingFangTC-Medium"
    static public var FontPingFangTCLight:String = "PingFangTC-Light"
    static public var FontPingFangTCThin:String = "PingFangTC-Thin"
    static public var FontPingFangTCSemibold:String = "PingFangTC-Semibold"
}
