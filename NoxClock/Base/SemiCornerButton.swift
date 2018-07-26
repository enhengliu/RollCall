//
//  SemiCornerButton.swift
//  NoxClock
//
//  Created by Andy_Liu on 2018/7/19.
//  Copyright © 2018年 Nox. All rights reserved.
//

import UIKit

class SemiCornerButton: UIButton {

    //MARK: - Initialize Method
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder);
        self.setBackgroundColor(color: self.backgroundColor!, forState: UIControlState.normal);
    }
    
    //MARK: - Life Cycle
    
    override func layoutSubviews() {
        
        super.layoutSubviews();
        self.layer.cornerRadius = self.bounds.size.height/2;
        self.layer.masksToBounds = true;
    }

}

extension UIButton {
    
    func setBackgroundColor(color: UIColor, forState: UIControlState) {
        
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, for: forState)
    }
}
