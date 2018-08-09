//
//  APIClient.swift
//  NoxClock
//
//  Created by Andy_Liu on 2018/8/6.
//  Copyright © 2018年 Nox. All rights reserved.
//

import Alamofire

class APIClient {
    
    static let shared = APIClient()
    private var headers:HTTPHeaders?;
    private let manager: Alamofire.SessionManager = {
        
        let configuration = URLSessionConfiguration.default;
        configuration.timeoutIntervalForRequest = 10;
        configuration.timeoutIntervalForResource = 10;
        return Alamofire.SessionManager(configuration: configuration);
    }()
    
    func httpRequest(method: RequestMethod, urlString: String, parameters: [String: String]?, handler: @escaping (APIResponse) -> Void) -> DataRequest {
        
        return manager.request(urlString, method: method.toAlamofile(), parameters: parameters, encoding: JSONEncoding.default,headers:headers).responseJSON { response in
            
            handler(APIResponse(code: response.response!.statusCode, value: response.result.value as AnyObject));
        }
    }
    
    func setHeader(parameters: [String: String]) {
        
        headers = parameters;
    }
}

enum RequestMethod {
    case GET
    case POST
    case PUT
    case DELETE
    
    func toAlamofile() -> Alamofire.HTTPMethod {
        switch self {
        case .GET:
            return .get
        case .POST:
            return .post
        case .PUT:
            return .put
        case .DELETE:
            return .delete
        }
    }
}

struct APIResponse {
    var status: APIStatus
    var value: AnyObject?
    var code:Int
    
    enum APIStatus {
        case Success
        case Failure
        
        public var isSuccess: Bool {
            switch self {
            case .Success:
                return true
            case .Failure:
                return false
            }
        }
    }
    
    init(code: Int = 0, value: AnyObject) {
        
        self.code = code;
        self.value = value

        switch code {
        case 200...299:
            status = APIStatus.Success
        default:
            status = APIStatus.Failure
        }
    }
}
