//
//  LoginViewController.swift
//  NoxClock
//
//  Created by Andy_Liu on 2018/7/26.
//  Copyright © 2018年 Nox. All rights reserved.
//

import UIKit
import KVOController
import Alamofire
import MBProgressHUD
import SwiftyJSON
import SwiftHash

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
    
    //MARK: - Button Method
    
    @IBAction func loginBtnOnPress(_ sender: Any) {
        
        self.login();
    }
    
    @IBAction func googleLoginBtnOnPress(_ sender: Any) {
        
        self.login();
    }
    
    //MARK: - API Method
    
    func login() {
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        ClockAPIClient.shared.login(accountTextField.text!, MD5(pwdTextField.text!).lowercased()) {  response in
            
            MBProgressHUD.hide(for: self.view, animated: true)
            switch response.status {
            case .OK:
                if let data = response.value{
                    
                    print(data)
                    let loginData:LoginData = LoginData(parameter:data as! JSON)
                    self.setMemberInfo(loginData);
                    self.setAuthHeader(loginData.token);
                    self.showToast("登入成功", completion: { didTap in
                        
                        self.gotoIndexViewController();
                    })
                }
                break;
                
            default:
                self.showToast("登入失敗", completion:nil)
                break;
            }
        }
    }
    
    //MARK: - Private Method
    
    private func setMemberInfo(_ loginData:LoginData) {
        
        Member.sharedInstance.employeeId = loginData.employeeId;
        Member.sharedInstance.employeeEmail = loginData.employeeEmail;
        Member.sharedInstance.token = loginData.token;
        let token = String(format: "Bearer %@", loginData.token);
        let headers: HTTPHeaders = ["Authorization": token]
        ClockAPIClient.shared.setHeader(parameters: headers);
        for punchData in loginData.punchInfo {
            
            if punchData.type == .PunchIn {
                
                Member.sharedInstance.clockInTime = punchData.getPunchDate();
            } else {
                
                Member.sharedInstance.clockOutTime = punchData.getPunchDate();
            }
        }
    }
    
    private func setAuthHeader(_ token:String) {
        
        let headers: HTTPHeaders = ["Authorization": token]
        ClockAPIClient.shared.setHeader(parameters: headers);
    }
    
    //MARK: - Other View
    
    func gotoIndexViewController()  {
        
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "IndexViewController")
        window.switchRootViewController(vc)
    }
}
