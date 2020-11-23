//
//  DesignableButton.swift
//  PayMate
//
//  Created by Emir Küçükosman on 10.11.2020.
//

import UIKit

@IBDesignable
class DesignableButton: UIButton {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
    }
    
    @IBInspectable
    var borderRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = borderRadius
        }
    }
    
}
