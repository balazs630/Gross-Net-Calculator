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
    @IBOutlet weak var vat: NSTextField!

    @IBAction func grossToNet(_ sender: Any) {
        net.doubleValue = (gross.doubleValue / 1.27).rounded()
        vat.doubleValue = gross.doubleValue - net.doubleValue
    }

    @IBAction func netToGross(_ sender: Any) {
        gross.doubleValue = (net.doubleValue * 1.27).rounded()
        vat.doubleValue = gross.doubleValue - net.doubleValue
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

