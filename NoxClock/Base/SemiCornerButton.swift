//
//  SemiCornerButton.swift
//  NoxClock
//
//  Created by Andy_Liu on 2018/7/19.
//  Copyright © 2018年 Nox. All rights reserved.
//

import UIKit

class SemiCornerButton: UIButton {

    //MARK: - Life Cycle
    
    override func layoutSubviews() {
        
        super.layoutSubviews();
        self.layer.cornerRadius = self.bounds.size.height/2;
        self.layer.masksToBounds = true;
    }

}
