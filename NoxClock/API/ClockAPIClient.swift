//
//  ClockAPIClient.swift
//  NoxClock
//
//  Created by Andy_Liu on 2018/8/7.
//  Copyright © 2018年 Nox. All rights reserved.
//

import Foundation
import SwiftyJSON

class ClockAPIClient {
    
    static let shared = ClockAPIClient()
    let apiHost:String = "http://220.130.130.109:3211/api/";
    
    private init() {
        
        if let token = Member.sharedInstance.token {
            
            let token = String(format: "Bearer %@", token);
            let headers: [String:String] = ["Authorization": token]
            setHeader(parameters: headers)
        }
    }
    
    func login(_ account:String,_ pwd:String, handler: @escaping (ClockAPIResponse) -> Void) {
        
        let parameters:[String:String]  = ["email":account,"password":pwd];
        let urlString = apiHost + "authentication/login"
        _ = APIClient.shared.httpRequest(method: .POST, urlString: urlString, parameters: parameters) {
            
            response in
            
            handler(ClockAPIResponse(code: response.code, value: response.value!))
        }
    }
    
    func getEmployeeData(_ employeeID:String, handler: @escaping (ClockAPIResponse) -> Void) {
        
        let urlString = String(format: "%@employee/employeeId/%@",apiHost,employeeID);
        _ = APIClient.shared.httpRequest(method: .GET, urlString: urlString, parameters: nil){
            
            response in
            
            handler(ClockAPIResponse(code: response.code, value: response.value!))
        }
    }
    
    func punchIn(_ employeeId:String,_ punchContent:String?,_ latitude:Double,_ longitude:Double, handler: @escaping (ClockAPIResponse) -> Void) {
        
        var parameters:[String:String]  = ["employeeId":employeeId,"workTypeId":"0","punchLatitude":String(latitude),"punchLongitude":String(longitude)];
        
        if punchContent != nil {
            
            parameters["punchContent"] = punchContent
        }
        
        let urlString = apiHost + "employee/punch"
        _ = APIClient.shared.httpRequest(method: .POST, urlString: urlString, parameters: parameters) {

            response in
            
            handler(ClockAPIResponse(code: response.code, value: response.value!))
        }
    }
    
    func punchOut(_ employeeId:String,_ punchContent:String?,_ latitude:Double,_ longitude:Double,_ punchId:String?,handler: @escaping (ClockAPIResponse) -> Void) {
        
        var parameters:[String:String]  = ["employeeId":employeeId,"workTypeId":"1","punchLatitude":String(latitude),"punchLongitude":String(longitude)];
        
        if punchId != nil {
            
            parameters["punchId"] = punchId
        }
        
        if punchContent != nil {
            
            parameters["punchContent"] = punchContent
        }
        
        let urlString = apiHost + "employee/punch"
        _ = APIClient.shared.httpRequest(method: .POST, urlString: urlString, parameters: parameters) {
            
            response in
            
            handler(ClockAPIResponse(code: response.code, value: response.value!))
        }
    }
    
    func setHeader(parameters: [String: String]) {
        
        APIClient.shared.setHeader(parameters: parameters);
    }
}

struct ClockAPIResponse {
    
    var value: AnyObject?
    var status:ClockAPIStatusCodes = .OK
    
    enum ClockAPIStatusCodes: Int {

        case OK
        case BadRequest = 400
        case Unauthorized
        case PaymentRequired
        case Forbidden
        case NotFound
        case MethodNotAllowed
        case NotAcceptable
        case ProxyAuthenticationRequired
        case RequestTimeout
        case Conflict
        case Gone
        case LengthRequired
        case PreconditionFailed
        case PayloadTooLarge
        case URITooLong
        case UnsupportedMediaType
        case RangeNotSatisfiable
        case ExpectationFailed
        case ImATeapot
        case MisdirectedRequest = 421
        case UnprocessableEntity
        case Locked
        case FailedDependency
        case UpgradeRequired = 426
        case PreconditionRequired = 428
        case TooManyRequests
        case RequestHeaderFieldsTooLarge = 431
        case UnavailableForLegalReasons = 451
        // 500 Server Error
        case InternalServerError = 500
        case NotImplemented
        case BadGateway
        case ServiceUnavailable
        case GatewayTimeout
        case HTTPVersionNotSupported
        case VariantAlsoNegotiates
        case InsufficientStorage
        case LoopDetected
        case NotExtended = 510
        case NetworkAuthenticationRequired
    }
    
    init(code: Int = 0, value: AnyObject) {
        
        let apiResponseData:APIResponseData = APIResponseData(parameter: JSON(value));
        switch apiResponseData.status {
            
        case .Success:
            self.value = apiResponseData.data as AnyObject
            break;
            
        case .Failure:
            self.value = apiResponseData.data as AnyObject
            self.status = ClockAPIResponse.ClockAPIStatusCodes(rawValue: code)!
            break;
            
        default:
            break;
        }
    }
}
