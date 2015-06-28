//
//  ViewController.swift
//  KeyboardNotiticationExample
//
//  Created by southpeak on 15/6/28.
//  Copyright (c) 2015年 xmu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var textField1: UITextField?
    @IBOutlet var textField2: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleKeyboardWillShowNotification:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleKeyboardDidShowNotification:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleKeyboardWillHideNotification:", name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleKeyboardDidHideNotification:", name: UIKeyboardDidHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleKeyboardWillChangeFrameNotification:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleeyboardDidChangeFrameNotification:", name: UIKeyboardDidChangeFrameNotification, object: nil)
        
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        textField1?.resignFirstResponder()
        textField2?.resignFirstResponder()
    }
    
    func handleKeyboardWillShowNotification(notification: NSNotification) {
        println("keyboard will show")
    }

    func handleKeyboardDidShowNotification(notification: NSNotification) {
        println("keyboard did show")
    }
    
    func handleKeyboardWillHideNotification(notification: NSNotification) {
        println("keyboard will hide")
    }
    
    func handleKeyboardDidHideNotification(notification: NSNotification) {
        println("keyboard did hide")
    }

    func handleKeyboardWillChangeFrameNotification(notification: NSNotification) {
        println("keyboard will change")
    }
    
    func handleeyboardDidChangeFrameNotification(notification: NSNotification) {
        println("keyboard did change")
        
        let dict = notification.userInfo
        if dict != nil {
            for (key, value) in dict! {
                println("\(key): \(value)")
            }
        }
    }
}

