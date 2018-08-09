//
//  LoginData.swift
//  NoxClock
//
//  Created by Andy_Liu on 2018/8/2.
//  Copyright © 2018年 Nox. All rights reserved.
//

import SwiftyJSON

class LoginData: EmployeeSimpleInfoData {
    
    let token:String!

    required init(parameter: JSON) {
        
        token = parameter["token"].stringValue
        super.init(parameter: parameter);
    }
}
