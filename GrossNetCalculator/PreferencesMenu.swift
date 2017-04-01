//
//  PreferencesMenu.swift
//  Gross-Net Calculator
//
//  Created by Horváth Balázs on 2016. 11. 26..
//  Copyright © 2016. Horváth Balázs. All rights reserved.
//

import Cocoa


class PreferencesMenu: NSViewController {
    
    @IBOutlet weak var txtVatRate: NSTextField!
    @IBOutlet weak var rbtnFt: NSButton!
    @IBOutlet weak var rbtnEuro: NSButton!
    @IBOutlet weak var rbtnDollar: NSButton!
    
    let numberValueFormatter = NumberValueFormatter()
    var prefs: UserDefaults = UserDefaults.standard
    
    @IBAction func currencyDidSelect(_ sender: NSButton) {
        prefs.set(sender.title, forKey: "currency")
        prefs.synchronize()
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        let enteredVatValue = numberValueFormatter.number(from: txtVatRate.stringValue)
    
        if enteredVatValue != nil {
            prefs.set(txtVatRate.stringValue, forKey: "vatRate")
            prefs.synchronize()
        }
        NotificationCenter.default.post(name: LABEL_REFRESH, object: nil)
        self.view.window?.close()
    }
    
    override func viewDidAppear() {
        let radioButtonState = prefs.string(forKey: "currency")!
        switch radioButtonState {
        case "Ft":
            rbtnFt.state = 1
        case "€":
            rbtnEuro.state = 1
        case "$":
            rbtnDollar.state = 1
        default:
            NSLog("Unexpected currency was selected")
        }

        txtVatRate.stringValue = prefs.string(forKey: "vatRate")!
    
        view.window!.styleMask.remove(NSWindowStyleMask.resizable)
        numberValueFormatter.maximumFractionDigits = 2
        numberValueFormatter.decimalSeparator = "."
        txtVatRate.formatter = numberValueFormatter
    }

}













