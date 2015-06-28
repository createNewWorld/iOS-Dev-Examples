//
//  ViewController.swift
//  TintColorExample
//
//  Created by southpeak on 15/6/27.
//  Copyright (c) 2015年 xmu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var dimTintSwitch: UISwitch?
    @IBOutlet var progressView: UIProgressView?
    @IBOutlet var tintedImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("\(self.view.tintAdjustmentMode.rawValue)")         // 输出：1
        println("\(self.view.tintColor)")                           // 输出：UIDeviceRGBColorSpace 0 0.478431 1 1
        
        self.view.tintAdjustmentMode = .Normal
        self.dimTintSwitch?.on = false
        
        // 加载图片
        var shinobiHead = UIImage(named: "shinobihead")
        // 设置渲染模式
        shinobiHead = shinobiHead?.imageWithRenderingMode(.AlwaysTemplate)
        
        self.tintedImageView?.image = shinobiHead
        self.tintedImageView?.contentMode = .ScaleAspectFit
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return UIInterfaceOrientation.Portrait.rawValue
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    @IBAction func changeColorHandler(sender: AnyObject) {
        
        let hue = CGFloat(arc4random() % 256) / 256.0
        let saturation = CGFloat(arc4random() % 128) / 256.0 + 0.5
        let brightness = CGFloat(arc4random() % 128) / 256.0 + 0.5
        
        let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
        self.view.tintColor = color
        updateViewConstraints()
    }
    
    @IBAction func dimTimtHandler(sender: AnyObject) {
        if let isOn = self.dimTintSwitch?.on {
            
            self.view.tintAdjustmentMode = isOn ? .Dimmed : .Normal
        }
        
        updateViewConstraints()
    }
    
    @IBAction func buttonHandler(sender: AnyObject) {
        
//        let alert = UIAlertView(title: "测试", message: "测试", delegate: nil, cancelButtonTitle: "确定")
//        alert.show()
    }
    
    private func updateProgressViewTint() {
        self.progressView?.progressTintColor = self.view.tintColor
    }
}

