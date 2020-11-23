//
//  DesignableCardView.swift
//  PayMate
//
//  Created by Emir Küçükosman on 24.11.2020.
//

import UIKit

@IBDesignable
class DesignableCardView: UIView {
    
    @IBInspectable
    var borderRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = borderRadius
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float = 0.0 {
        didSet {
            self.layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat = 0.0 {
        didSet {
            self.layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize = CGSize(width: 0, height: 0) {
        didSet {
            self.layer.shadowOffset = shadowOffset
        }
    }
    
}
