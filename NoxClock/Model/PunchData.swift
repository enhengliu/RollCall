//
//  PunchData.swift
//  NoxClock
//
//  Created by Andy_Liu on 2018/7/27.
//  Copyright © 2018年 Nox. All rights reserved.
//

import UIKit
import SwiftyJSON

class PunchData: BaseModelProtocol {

    let punchDate:String!
    let punchContent:String!
    let workTypeId:Int!
    
    required init(parameter: JSON) {
        
        punchDate = parameter["punchDate"].stringValue
        punchContent = parameter["punchContent"].stringValue
        workTypeId = parameter["workTypeId"].intValue
    }
}
