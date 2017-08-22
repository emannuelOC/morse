//
//  ViewController.swift
//  MetronomoDoKIQ
//
//  Created by Emannuel Carvalho on 22/08/17.
//  Copyright © 2017 Emannuel Carvalho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var text = ""
    var lastTouchDate: Date?
    
    lazy var receivingView: UIView = { () -> UIView in
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.1193554452, blue: 0.378529672, alpha: 1)
        return view
    }()
    
    lazy var sendingView: UIView = { () -> UIView in
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        let tap = UITapGestureRecognizer(target: self, action: #selector(recognizeTap))
        view.addGestureRecognizer(tap)
        let long = UILongPressGestureRecognizer(target: self, action: #selector(recognizeLongTouch(_:)))
        view.addGestureRecognizer(long)
        return view
    }()

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        receivingView.alpha = 0.5
        sendingView.alpha = 0.5
        receivingView.translatesAutoresizingMaskIntoConstraints = false
        sendingView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(sendingView)
        self.view.addSubview(receivingView)
        NSLayoutConstraint(item: receivingView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: self.view,
                           attribute: .top,
                           multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: receivingView,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: self.view,
                           attribute: .leading,
                           multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: receivingView,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: self.view,
                           attribute: .trailing,
                           multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: sendingView,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: self.receivingView,
                           attribute: .height,
                           multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: sendingView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: self.receivingView,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: sendingView,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: self.view,
                           attribute: .leading,
                           multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: sendingView,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: self.view,
                           attribute: .trailing,
                           multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: sendingView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: self.view,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: 0).isActive = true
    }
    
    func recognizeTap() {
        if let last = lastTouchDate {
            if Date().timeIntervalSince(last) > 2 {
                text += " ."
            } else {
                text += "."
            }
        } else {
            text += "."
        }
        lastTouchDate = Date()
        title = text.translateMorse()
        UIView.animate(withDuration: 0.1, animations: { 
            self.sendingView.alpha = 1
        }) { (_) in
            self.sendingView.alpha = 0.5
        }
    }
    
    func recognizeLongTouch(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            sendingView.alpha = 1
        } else if gesture.state == .ended || gesture.state == .cancelled {
            sendingView.alpha = 0.5
            if let last = lastTouchDate {
                if Date().timeIntervalSince(last) > 2 {
                    text += " -"
                } else {
                    text += "-"
                }
            } else {
                text += "- "
            }
            title = text.translateMorse()
            lastTouchDate = Date()
        }
    }
    
}


extension String {
    
    func translateMorse() -> String {
        var result = ""
        
        var translate = [
            ".-": "A",
            "-...": "B",
            "-.-.": "C",
            "-..": "D",
            ".": "E",
            "..-.": "F",
            "--.": "G",
            "....": "H",
            "..": "I",
            ".---": "J",
            "-.-": "K",
            ".-..": "L",
            "--": "M",
            "-.": "N",
            "---": "O",
            ".--.": "P",
            "--.-": "Q",
            ".-.": "R",
            "...": "S",
            "-": "T",
            "..-": "U",
            "...-": "V",
            ".--": "W",
            "-..-": "X",
            "-.--": "Y",
            "--..": "Z"
            ]
        
        self.components(separatedBy: " ").forEach { (morse) in
            if let letter = translate[morse] {
                result += letter
            } else {
                result += "*"
            }
        }
        
        return result
        
    }
    
}
