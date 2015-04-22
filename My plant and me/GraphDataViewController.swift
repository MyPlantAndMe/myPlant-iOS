//
//  GraphDataViewController.swift
//  My plant and me
//
//  Created by zephyz on 19/04/15.
//  Copyright (c) 2015 purplicious. All rights reserved.
//

import UIKit

class GraphDataViewController: UIViewController {
    

    @IBOutlet weak var historyValues: UITextView! {
        didSet {
            historyValues.text = values
        }
    }
    
    @IBOutlet weak var actionButton: UIButton! {
        didSet {
            actionButton.setTitle(buttonText, forState: UIControlState.Normal)
        }
    }
    
    @IBOutlet weak var graph: UIImageView!
    
    @IBAction func performAction(sender: UIButton) {
        if let controller = self.popoverPresentationController {
            if let vc = controller.delegate as? MainViewController {
                switch sender.currentTitle! {
                case "increase temperature":  vc.increaseTemperature(sender)
                case "water plant": vc.WaterPlant(sender)
                case "turn on lights":
                    vc.changeLights(sender)
                default: break
                }

            }
        }
    }
    
    var buttonText: String = "" {
        didSet {
            println("set text in popover " + buttonText)
            actionButton?.setTitle(buttonText, forState: UIControlState.Normal)
        }
    }
    
    var values: String = "[]" {
        didSet {
            historyValues?.text = values
        }
        
    }

    override var preferredContentSize: CGSize {
        get {
            if graph != nil && presentingViewController != nil {
                return graph.sizeThatFits(presentingViewController!.view.bounds.size)
            } else {
                return super.preferredContentSize
            }
        }
        set { super.preferredContentSize = newValue }
    }
}
