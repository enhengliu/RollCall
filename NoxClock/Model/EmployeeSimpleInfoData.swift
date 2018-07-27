//
//  EmployeeSimpleInfoData.swift
//  NoxClock
//
//  Created by Andy_Liu on 2018/7/27.
//  Copyright © 2018年 Nox. All rights reserved.
//

import UIKit
import SwiftyJSON

class EmployeeSimpleInfoData: BaseModelProtocol {

    let employeeId:String!
    let employeeBirth:String!
    let employeeTel:String!
    let employeeName:String!
    let employeeEmail:String!
    let employeeTitle:String!
    let punchInfo:[PunchData]!

    required init(parameter: JSON) {
        employeeId = parameter["employeeId"].stringValue
        employeeBirth = parameter["employeeBirth"].stringValue
        employeeTel = parameter["employeeTel"].stringValue
        employeeName = parameter["employeeName"].stringValue
        employeeEmail = parameter["employeeEmail"].stringValue
        employeeTitle = parameter["employeeTitle"].stringValue
        punchInfo = parameter["punchInfo"].arrayValue.map {return PunchData(parameter: $0)}
    }
}
