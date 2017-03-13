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
    
    let numberValueFormatter = NumberValueFormatter()
    var prefs: UserDefaults = UserDefaults.standard
    
    @IBAction func currencyDidSelect(_ sender: NSButton) {
        prefs.set(sender.title, forKey: "currency")
        prefs.synchronize()
    }
    
    @IBAction func doneButton(_ sender: Any) {
        let enteredVatValue = numberValueFormatter.number(from: vatRate.stringValue)
    
        if enteredVatValue != nil {
            prefs.set(vatRate.stringValue, forKey: "vatRate")
            prefs.synchronize()
        }
        NotificationCenter.default.post(name: LABEL_REFRESH, object: nil)
        self.view.window?.close()
    }
    
    override func viewDidAppear() {
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
    
        view.window!.styleMask.remove(NSWindowStyleMask.resizable)
        numberValueFormatter.maximumFractionDigits = 2
        numberValueFormatter.decimalSeparator = "."
        vatRate.formatter = numberValueFormatter
    }

}













