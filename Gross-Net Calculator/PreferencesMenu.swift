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
    @IBOutlet weak var radioButtonFt: NSButton!
    @IBOutlet weak var radioButtonEuro: NSButton!
    @IBOutlet weak var radioButtonDollar: NSButton!
    
    var prefs: UserDefaults = UserDefaults.standard
    
    @IBAction func chooseCurrency(_ sender: NSButton) {
        prefs.set(sender.title, forKey: "currency")
        prefs.synchronize()
    }
    
    @IBAction func doneButton(_ sender: Any) {
        let enteredVatValue = Int(vatRate.stringValue)
        if enteredVatValue == nil {
            
        } else {
            prefs.set(vatRate.stringValue, forKey: "vatRate")
        }
        
        prefs.synchronize()
        self.view.window?.close()
    }
    
    func checkUserDefaultsExist() {
        if prefs.object(forKey: "vatRate") == nil {
            prefs.set(27, forKey: "vatRate")
        }
        if prefs.object(forKey: "currency") == nil {
            radioButtonFt.state = 1
        }
        prefs.synchronize()
    }
    
    override func viewDidAppear() {
        checkUserDefaultsExist()
        
        let radioButtonState = prefs.string(forKey: "currency")!
        switch radioButtonState {
        case "Ft":
            radioButtonFt.state = 1
        case "€":
            radioButtonEuro.state = 1
        case "$":
            radioButtonDollar.state = 1
        default:
            NSLog("Unexpected currency was selected")
        }

        vatRate.stringValue = prefs.string(forKey: "vatRate")!
    }

}