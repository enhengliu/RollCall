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
}
