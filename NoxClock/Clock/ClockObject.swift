//
//  ClockObject.swift
//  NoxClock
//
//  Created by Andy_Liu on 2018/7/12.
//  Copyright © 2018年 Nox. All rights reserved.
//

import UIKit

class ClockObject: NSObject {

    var second:Int {
        
        get{
            return Calendar.current.component(.second, from: Date());
        }
    }

    var minute:Int {
        
        get{
            return Calendar.current.component(.minute, from: Date());
        }
    }
    
    var hour:Int {
        
        get{
            return Calendar.current.component(.hour, from: Date());
        }
    }
    
    //MARK: - Initialize Method
    
    override init() {
        
        super.init();
//        self.setupData();
    }
    
    //MARK: - Setup Method
    
    private func setupData() {
        
//        hour = Calendar.current.component(.hour, from: Date())
//        if hour >= 12 {hour = hour - 12;}
//        minute = Calendar.current.component(.minute, from: Date())
//        second = Calendar.current.component(.second, from: Date())
    }
}
