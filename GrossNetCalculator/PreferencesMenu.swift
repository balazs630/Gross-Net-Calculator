//
//  PreferencesMenu.swift
//  GrossNetCalculator
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
    var choosenCurrency: String = ""
    
    var currency: String {
        return prefs.string(forKey: "currency")!
    }
    
    var vatRate: Double {
        return prefs.double(forKey: "vatRate")
    }
    
    @IBAction func currencyDidSelect(_ sender: NSButton) {
        choosenCurrency = sender.title
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        let enteredVatValue = numberValueFormatter.number(from: txtVatRate.stringValue)
    
        if enteredVatValue != nil && enteredVatValue?.doubleValue != vatRate {
            prefs.set(txtVatRate.stringValue, forKey: "vatRate")
            NotificationCenter.default.post(name: UPDATE_TEXTFIELDS, object: nil)
            prefs.synchronize()
        }
        
        if choosenCurrency != currency {
            prefs.set(choosenCurrency, forKey: "currency")
            NotificationCenter.default.post(name: UPDATE_CURRENCY_LABELS, object: nil)
            prefs.synchronize()
        }
        
        self.view.window?.close()
    }
    
    override func viewDidAppear() {
        switch currency {
        case "Ft":
            rbtnFt.state = 1
        case "€":
            rbtnEuro.state = 1
        case "$":
            rbtnDollar.state = 1
        default:
            NSLog("Unexpected currency was selected")
        }

        choosenCurrency = currency
        txtVatRate.doubleValue = vatRate
    
        numberValueFormatter.maximumFractionDigits = 2
        numberValueFormatter.decimalSeparator = "."
        txtVatRate.formatter = numberValueFormatter
    }

}
