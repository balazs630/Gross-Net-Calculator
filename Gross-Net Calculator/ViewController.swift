//
//  ViewController.swift
//  Gross-Net Calculator
//
//  Created by Horváth Balázs on 2016. 10. 18..
//  Copyright © 2016. Horváth Balázs. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var gross: NSTextField!
    @IBOutlet weak var net: NSTextField!
    
    
    @IBAction func grossToNet(_ sender: AnyObject) {
        net.doubleValue = (gross.doubleValue / 1.27).rounded()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
            
        // Update the view, if already loaded.
            
        }
    }

}

