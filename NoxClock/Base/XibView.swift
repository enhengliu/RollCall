//
//  XibView.swift
//  NoxClock
//
//  Created by Andy_Liu on 2018/7/12.
//  Copyright © 2018年 Nox. All rights reserved.
//

import UIKit

class XibView: UIView {

    var nibView: UIView;
    //MARK: - Initialize Method
    
    required init?(coder aDecoder: NSCoder) {
        
        nibView = UIView();
        super.init(coder: aDecoder);
        let objects = Bundle.main.loadNibNamed(String(describing:type(of: self)), owner: self, options: nil);
        nibView = objects?.first as! UIView;
        let viewSize:CGSize = self.bounds.size;
        nibView.frame = CGRect(x: 0, y: 0, width: viewSize.width, height: viewSize.height);
        self.backgroundColor = UIColor.clear;
        self .addSubview(nibView);
    }

}
