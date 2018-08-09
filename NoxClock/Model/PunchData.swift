//
//  PunchData.swift
//  NoxClock
//
//  Created by Andy_Liu on 2018/7/27.
//  Copyright © 2018年 Nox. All rights reserved.
//

import SwiftyJSON

class PunchData: BaseModelProtocol {

    let punchDate:String!
    let punchContent:String!
    let type:PunchType!

    enum PunchType: Int {
        
        case PunchIn = 0
        case PunchOut = 1
    }
    
    required init(parameter: JSON) {
        
        punchDate = parameter["punchDate"].stringValue
        punchContent = parameter["punchContent"].stringValue
        let workTypeId = parameter["workTypeId"].intValue
        type = PunchData.PunchType(rawValue: workTypeId)
    }
    
    func getPunchDate() -> Date? {
        
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        if let date = formatter.date(from: punchDate) {
            
            return date;
        }
        
        return nil
    }
}
