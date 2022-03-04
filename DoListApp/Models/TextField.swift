//
//  TextField.swift
//  DoListApp
//
//  Created by YANA on 02/03/2022.
//

import UIKit

class TextField: UITextField {
    
  // set padding inside UITextField
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    // set max lenght to UITextField
    var maxLength: Int = 30
    
    override func willMove(toSuperview newSuperview: UIView?) {
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        editingChanged()
    }
    
    @objc func editingChanged() {
        text = String(text!.prefix(maxLength))
    }
}


