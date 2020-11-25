//
//  BorderedTextField.swift
//  Form
//
//  Created by Arun Eswaramurthi on 07/07/20.
//  Copyright © 2020 Knila. All rights reserved.
//

import UIKit

class BorderedTextField: UITextField {
    /// Toggle this to display eye icon on the textfield
	var isSecureField: Bool = false {
		didSet {
			if self.isSecureField {
				isSecureTextEntry = true
				makeFieldSecure()
			} else {
				rightView = nil
				rightViewMode = .never
			}
		}
	}
	
	var shouldAddBorder: Bool = true {
		didSet {
			if self.shouldAddBorder == false {
				self.layer.borderColor = nil
				self.layer.borderWidth = 0
				self.borderStyle = .roundedRect
			}
		}
	}
    
    public var textInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.beautify()
    }
    
    convenience init() {
        self.init(frame: .zero)
        
        self.beautify()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.beautify()
    }
    
    private func beautify() {
		let borderColor = FormConfiguration.current.textFieldBorderColor ?? FormConfiguration.current.themeColor
		self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 0.5
		self.tintColor = borderColor
    }
    
    private func makeFieldSecure() {
        if (rightView as? UIButton) != nil { return }
		
		let hiddenImage = UIImage(named: "hidden-eye", in: Bundle(for: BorderedTextField.self), compatibleWith:nil)
        let button   = UIButton(type: .custom) as UIButton
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.setImage(hiddenImage, for: .normal)
        button.addTarget(self, action: #selector(hideShowPasswordTextField(sender:)), for: .touchUpInside)
        
        rightView = button
        rightViewMode = .always
    }
    
    @objc func hideShowPasswordTextField(sender: AnyObject) {
        guard let hideShow = rightView as? UIButton else { return }
        
        if !isSecureTextEntry {
            isSecureTextEntry = true
			let hiddenImage = UIImage(named: "hidden-eye", in: Bundle(for: BorderedTextField.self), compatibleWith:nil)
            hideShow.setImage(hiddenImage, for: .normal)
        } else {
            isSecureTextEntry = false
			let visibleImage = UIImage(named: "visibility-eye", in: Bundle(for: BorderedTextField.self), compatibleWith:nil)
			hideShow.setImage(visibleImage, for: .normal)
        }
        
        becomeFirstResponder()
    }
    
    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
    
    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
    
    open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
    
    open override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
}
