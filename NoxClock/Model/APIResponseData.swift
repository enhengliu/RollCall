//
//  APIResponseData.swift
//  NoxClock
//
//  Created by Andy_Liu on 2018/8/7.
//  Copyright © 2018年 Nox. All rights reserved.
//

import SwiftyJSON

class APIResponseData: BaseModelProtocol {
    
    let status:APIResponseStatus!
    let data: JSON!
    
    enum APIResponseStatus {
        case Success
        case Failure
    }
    
    required init(parameter: JSON) {
        
        let value:String = parameter["status"].stringValue
        status = APIResponseData.getStatus(value)
        data = parameter["data"]
    }
    
    static private func getStatus(_ value:String) -> APIResponseStatus {
        
        switch value {
        case "success":
            return .Success;
        case "error":
            return .Failure;
        default:
            return .Failure;
        }
    }
}
