//
//  UIWindow+Transition.swift
//  NoxClock
//
//  Created by Andy_Liu on 2018/8/2.
//  Copyright © 2018年 Nox. All rights reserved.
//

import UIKit

extension UIWindow {
    
    func switchRootViewController(_ viewController: UIViewController,  animated: Bool = true, duration: TimeInterval = 0.3, options: UIViewAnimationOptions = .transitionCrossDissolve, completion: (() -> Void)? = nil) {
        guard animated else {
            rootViewController = viewController
            return
        }
        
        UIView.transition(with: self, duration: duration, options: options, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            self.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
        }) { _ in
            completion?()
        }
    }
}
