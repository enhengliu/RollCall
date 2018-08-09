//
//  Member.swift
//  NoxClock
//
//  Created by Andy_Liu on 2018/8/2.
//  Copyright © 2018年 Nox. All rights reserved.
//

import UIKit

class Member: NSObject {

    static let sharedInstance = Member()
    
    var token:String? {
        
        didSet {
            
            setToken();
        }
    };
    
    private override init() {
        
        if let memberToken = UserDefaults.standard.object(forKey: "Token") as? String {
            
            token = memberToken
        }
        
        if let Id = UserDefaults.standard.object(forKey: "EmployeeId") as? String {
            
            employeeId = Id
        }
    }
    
    var isLogin:Bool {
        
        get {
            
            return (self.token != nil)
        }
    }
    
    var employeeId:String? {
        
        didSet {
            
            setEmployeeId();
        }
    }
    var employeeEmail:String?
    var clockInTime:Date?
    var clockOutTime:Date?
    
    func setToken() {
        
        UserDefaults.standard.set(token, forKey: "Token");
    }
    
    func setEmployeeId() {
        
        UserDefaults.standard.set(employeeId, forKey: "EmployeeId");
    }
}
