//
//  RoundLabel.swift
//  UIApearanceExample
//
//  Created by hanhui on 15/7/18.
//  Copyright (c) 2015年 iosdev. All rights reserved.
//

import UIKit

class RoundLabel: UILabel {
    
    dynamic func setBorderColor(color: UIColor) {
        layer.borderColor = color.CGColor
    }
    
    dynamic func setBorderWidth(width: CGFloat) {
        layer.borderWidth = width
    }
    
    dynamic func setCornerRadius(radius: CGFloat) {
        layer.cornerRadius = radius
    }
}
