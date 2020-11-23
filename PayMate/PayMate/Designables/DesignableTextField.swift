//
//  UITextField+.swift
//  PayMate
//
//  Created by Emir Küçükosman on 10.11.2020.
//

import UIKit

@IBDesignable
class DesignableUITextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x -= rightPadding
        return textRect
    }
    
    @IBInspectable
    var rightImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var rightPadding: CGFloat = 0
    
    @IBInspectable
    var color: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var borderRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = borderRadius
        }
    }
    
    func updateView() {
        if let image = rightImage {
            rightViewMode = .always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            imageView.tintColor = color
            rightView = imageView
        } else {
            rightViewMode = .never
            rightView = nil
        }
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
    }

}
