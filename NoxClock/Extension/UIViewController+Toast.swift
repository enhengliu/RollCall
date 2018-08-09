//
//  UIView+Toast.swift
//  NoxClock
//
//  Created by Andy_Liu on 2018/8/2.
//  Copyright © 2018年 Nox. All rights reserved.
//

import UIKit
import Toast_Swift

extension UIViewController {
    
    func showToast(_ message: String , completion: ((_ didTap: Bool) -> Void)? = nil) {
        
        if message.count == 0 { return };
        var style = ToastStyle()
        style.messageFont = UIFont.systemFont(ofSize: 17.0)
        style.horizontalPadding = 30;
        style.verticalPadding = 30;
        style.fadeDuration = 0.3;
        style.titleAlignment = NSTextAlignment.center;
        self.view.makeToast(message, duration: 0.8, position: ToastPosition.center, title: nil, image: nil, style: style, completion: completion)
//        [self.view makeToast:message duration:0.8f position:CSToastPositionCenter title:nil image:nil style:style completion:completion];
    }
    
}
