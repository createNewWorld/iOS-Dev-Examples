//
//  CustomControl.swift
//  TintColorExample
//
//  Created by southpeak on 15/6/28.
//  Copyright (c) 2015年 xmu. All rights reserved.
//

import UIKit

class CustomControl: UIView {

    private var tintColorBlock: UIView
    private var greyLabel: UILabel
    private var tintColorLabel: UILabel
    
    required init(coder aDecoder: NSCoder) {
        
        tintColorBlock = UIView()
        greyLabel = UILabel()
        tintColorLabel = UILabel()
        
        super.init(coder: aDecoder)
        
        self.backgroundColor = UIColor.clearColor()
        
        prepareSubviews()
    }
    
    private func prepareSubviews() {
        
        tintColorBlock.backgroundColor = self.tintColor
        self.addSubview(tintColorBlock)
        
        greyLabel.text = "灰色Label"
        greyLabel.textColor = UIColor.grayColor()
        greyLabel.sizeToFit()
        self.addSubview(greyLabel)
        
        tintColorLabel.text = "Tint color label"
        tintColorLabel.textColor = self.tintColor
        tintColorLabel.sizeToFit()
        self.addSubview(tintColorLabel)
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        tintColorBlock.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.bounds) / 3, CGRectGetHeight(self.bounds))
        
        var frame = greyLabel.frame
        frame.origin.x = CGRectGetWidth(self.bounds) / 3 + 10.0
        frame.origin.y = 0.0
        greyLabel.frame = frame
        
        frame = tintColorLabel.frame
        frame.origin.x = CGRectGetWidth(self.bounds) / 3 + 10.0
        frame.origin.y = CGRectGetHeight(self.bounds) / 2.0
        tintColorLabel.frame = frame
    }

    override func tintColorDidChange() {
        tintColorLabel.textColor = self.tintColor
        tintColorBlock.backgroundColor = self.tintColor
    }
}
