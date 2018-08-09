//
//  SimpleTextField.swift
//  NoxClock
//
//  Created by Andy_Liu on 2018/7/26.
//  Copyright © 2018年 Nox. All rights reserved.
//

import UIKit

protocol SimpleTextFieldDelegate:class {

}

class SimpleTextField: XibView, UITextFieldDelegate {
    
    @IBOutlet private var mainTextField: UITextField! { didSet { mainTextField.delegate = self }}
    @IBOutlet private var separatorView: UIView!
    @IBOutlet private var separatorAnimationView: UIView!
    @IBOutlet private var separatorAnimationViewWConstraint: NSLayoutConstraint!
    @IBOutlet private var topConstraint: NSLayoutConstraint!
    @IBOutlet private var trailingConstraint: NSLayoutConstraint!
    @IBOutlet private var leadingConstraint: NSLayoutConstraint!
    @IBOutlet private var bottomConstraint: NSLayoutConstraint!
    public weak var delegate:SimpleTextFieldDelegate?;
    var placeholderFont: UIFont = UIFont() { didSet { setPlaceholderFont(font: placeholderFont) }}
    var contentFont: UIFont = UIFont() { didSet { setContentFont(font: contentFont) }}
    @IBInspectable var placeholderColor: UIColor = UIColor.white { didSet { setPlaceholderColor(color: placeholderColor) }}
    @IBInspectable var contentColor: UIColor = UIColor.white { didSet { setContentColor(color: contentColor) }}
    @IBInspectable var placeholder: String = "" { didSet { setPlaceholder(placeholder: placeholder) }}
    @IBInspectable var content: String = "" { didSet { setContent(content: content) }}
    @IBInspectable var separatorColor: UIColor = UIColor.white { didSet { setSeparatorColor(color: separatorColor) }}
    public var text:String? {
        
        get {
            
            return mainTextField.text;
        }
    }
    //MARK :- Public Method
    
    public func setPlaceholder(placeholder: String) {
        
        mainTextField.placeholder = placeholder;
    }
    
    public func setSeparatorColor(color: UIColor) {
        
        separatorView.backgroundColor = color;
    }
    
    public func setPlaceholderFont(font: UIFont) {
        
        let attributes = [NSAttributedStringKey.font: font,NSAttributedStringKey.foregroundColor: placeholderColor]
        mainTextField.attributedPlaceholder = NSAttributedString(string:mainTextField.placeholder!, attributes:attributes)
    }
    
    public func setContentFont(font: UIFont) {
        
        mainTextField.font = font;
    }
    
    public func setPlaceholderColor(color: UIColor) {
        
        let attributes = [NSAttributedStringKey.font: placeholderFont,NSAttributedStringKey.foregroundColor: color]
        mainTextField.attributedPlaceholder = NSAttributedString(string:mainTextField.placeholder!, attributes:attributes)
    }
    
    public func setContentColor(color: UIColor) {

        mainTextField.textColor = color;
        separatorAnimationView.backgroundColor = color;
    }
    
    public func setContent(content: String) {
        
        mainTextField.text = content;
    }
    
    public func setEdgeInsets(edgeInsets: UIEdgeInsets) {
        
        topConstraint.constant = edgeInsets.top;
        leadingConstraint.constant = edgeInsets.left;
        trailingConstraint.constant = edgeInsets.right;
        bottomConstraint.constant = edgeInsets.bottom;
    }
    
    public func becomeFirstResponder() {
        
        mainTextField.becomeFirstResponder()
    }
    
    public func resignFirstResponde() {
        
        mainTextField.resignFirstResponder()
    }
    
    //MARK : - Animation Method
    
    private func showSeparatorViewAnimation () {
        
        separatorAnimationView.isHidden = false;
        separatorAnimationViewWConstraint.constant = separatorView.bounds.size.width;
        UIView.animate(withDuration: 0.5, animations: {
            
            self.layoutIfNeeded();
        })
    }
    
    private func hideSeparatorViewAnimation () {
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.separatorAnimationView.alpha = 0.0

        }) {
            complete in
            
            self.separatorAnimationViewWConstraint.constant = 0;
            self.separatorAnimationView.alpha = 1.0
            self.separatorAnimationView.isHidden = true;
        }
    }
    
    //MARK : - UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        showSeparatorViewAnimation();
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        hideSeparatorViewAnimation();
    }
}
