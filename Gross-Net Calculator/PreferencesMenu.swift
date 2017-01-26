//
//  PreferencesMenu.swift
//  Gross-Net Calculator
//
//  Created by Horváth Balázs on 2016. 11. 26..
//  Copyright © 2016. Horváth Balázs. All rights reserved.
//


import Cocoa


class PreferencesMenu: NSViewController {
    
    @IBOutlet weak var vatRate: NSTextField!
    
    
    @IBAction func doneButton(_ sender: Any) {
        self.view.window?.close()
    }
    
    override func viewDidAppear() {
        vatRate.stringValue = "27"
    }

}
