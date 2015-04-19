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
            historyValues.text = text
        }
    }
    
    @IBOutlet weak var actionButton: UIButton! {
        didSet {
            actionButton.setTitle(text, forState: UIControlState.Normal)
        }
    }
    var text: String = "" {
        didSet {
            historyValues?.text = text
            actionButton?.setTitle(text, forState: UIControlState.Normal)
        }
    }

}
