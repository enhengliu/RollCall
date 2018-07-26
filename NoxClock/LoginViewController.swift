//
//  LoginViewController.swift
//  NoxClock
//
//  Created by Andy_Liu on 2018/7/26.
//  Copyright © 2018年 Nox. All rights reserved.
//

import UIKit
import KVOController

class LoginViewController: BaseViewController {

    @IBOutlet var accountTextField: SimpleTextField! {
        didSet {
            accountTextField.setContentFont(font: UIFont(name: CommonDefine.FontPingFangTCSemibold, size: 19)!);
            accountTextField.setPlaceholderFont(font: UIFont(name: CommonDefine.FontPingFangTCThin, size: 19)!);
        }
    }
    @IBOutlet var pwdTextField: SimpleTextField! {
        
        didSet {
            pwdTextField.setContentFont(font: UIFont(name: CommonDefine.FontPingFangTCSemibold, size: 19)!);
            pwdTextField.setPlaceholderFont(font: UIFont(name: CommonDefine.FontPingFangTCThin, size: 19)!);
        }
    }
    var tapGesture:UITapGestureRecognizer?;
    @IBOutlet private var mainScrollView: UIScrollView!
    @IBOutlet var scrollViewContentHeightConstraint: NSLayoutConstraint!
    @IBOutlet var paddingViewHConstraint: NSLayoutConstraint!
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setupGesture();
        self.setupKVO();
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Setup Method
    
    func setupGesture() {
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.handleTap(_:)))
        self.view.addGestureRecognizer(tapGesture!);
    }
    
    func setupKVO() {
        
        kvoController.observe(mainScrollView,keyPath: "contentSize",options: [.new]) { (viewController, object, change) in
            
            
            if self.view.bounds.size.height - 100 < self.mainScrollView.contentSize.height {

                let offset = self.mainScrollView.contentSize.height - (self.view.bounds.size.height - 100 - self.paddingViewHConstraint.constant);
                let padding = self.paddingViewHConstraint.constant - offset;
                self.paddingViewHConstraint.constant = padding >= 0 ?padding:0;
                self.scrollViewContentHeightConstraint.constant = self.mainScrollView.contentSize.height;

            }else {

                self.paddingViewHConstraint.constant = 138;
                self.scrollViewContentHeightConstraint.constant = self.mainScrollView.contentSize.height;
            }
        }
    }
    
    //MARK: - Gesture Method
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
        self.view.endEditing(true);
    }
}
