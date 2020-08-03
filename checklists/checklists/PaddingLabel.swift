//
//  PaddingLabel.swift
//  checklists
//
//  Created by Varun Tandon on 03/08/20.
//  Copyright © 2020 Varun Tandon. All rights reserved.
//

import UIKit

@IBDesignable class PaddingLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 14.0
    @IBInspectable var bottomInset: CGFloat = 14.0
    @IBInspectable var leftInset: CGFloat = 0.0
    @IBInspectable var rightInset: CGFloat = 0.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset,
                                       bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}
