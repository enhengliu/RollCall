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

class SimpleTextField: XibView {
    
    @IBOutlet private var mainTextField: UITextField!
    @IBOutlet private var separatorView: UIView!
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
}
