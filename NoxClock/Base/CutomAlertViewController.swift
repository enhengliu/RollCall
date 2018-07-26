//
//  CutomAlertViewController.swift
//  NoxClock
//
//  Created by Andy_Liu on 2018/7/19.
//  Copyright © 2018年 Nox. All rights reserved.
//

import UIKit

class CutomAlertViewController: BaseViewController {

    public var maskView:UIView?
    public var contentView:UIView?

    //MARK: - initialize Method
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
        self.setupGesture();
        self.view.backgroundColor = UIColor.clear;
        self.modalTransitionStyle = UIModalTransitionStyle.crossDissolve;
        self.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated);
        
        if animated == true {
            
            self.showMaskView();
            self.showContentView();
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated);
        
        if animated == true {
            
            self.hideMaskView();
        }
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Setup Method

    func setupGesture() {
        
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CutomAlertViewController.handleTap))
        self.view.addGestureRecognizer(tapGesture);
    }
    
    //MARK: - Gesture Method
    
    @objc func handleTap() {
        
        self.hide();
    }

    //MARK: - Public Method

    func showInViewController(_ viewController: UIViewController) {
        
        viewController.present(self, animated: true, completion: nil);
    }
    
    @objc func hide() {
        
        self.dismiss(animated: true, completion: nil);
    }
    
    //MARK: - Private Method
    
    private func showMaskView () {
        
        if (maskView != nil) {
            
            maskView?.alpha = 0.0;
            UIView.animate(withDuration: 0.4) {
                
                self.maskView?.alpha = 0.7;
            }
        }
    }
    
    private func hideMaskView () {
        
        if (maskView != nil) {
            
            UIView.animate(withDuration: 0.4) {
                
                self.maskView?.alpha = 0.0;
            }
        }
    }
    
    private func showContentView () {
        
        if (contentView != nil) {
            
            self.contentView?.transform = CGAffineTransform.identity;
            contentView?.transform =  CGAffineTransform.init(scaleX: 0.5, y: 0.5);
            UIView.animate(withDuration: 0.3/1.5, animations: {

                self.contentView?.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1);
            }) { (complete) in
               
                UIView.animate(withDuration: 0.3/2, animations: {
                    
                    self.contentView?.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9);
                }) { (complete) in
                    
                    UIView.animate(withDuration: 0.3/3) {
                        
                        self.contentView?.transform = CGAffineTransform.identity;
                    }
                }
            }
        }
    }
}
