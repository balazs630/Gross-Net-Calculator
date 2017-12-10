//
//  PreferencesViewController.swift
//  GrossNetCalculator
//
//  Created by Horváth Balázs on 2017. 04. 13.
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import Cocoa

class PreferencesViewController: NSViewController {

    @IBOutlet weak var txtVatRate: NSTextField!

    @IBOutlet weak var rbtnFt: NSButton!
    @IBOutlet weak var rbtnEuro: NSButton!
    @IBOutlet weak var rbtnDollar: NSButton!

    var defaults: UserDefaults = UserDefaults.standard
    let numberValueFormatter = NumberValueFormatter()
    var choosenCurrency: String = ""

    var currency: String {
        return defaults.string(forKey: UserDefaultsKeys.currency)!
    }

    var vatRate: Double {
        return defaults.double(forKey: UserDefaultsKeys.vatRate)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }

    override func viewDidAppear() {
        switch currency {
        case CurrencySign.forint:
            rbtnFt.state = NSControl.StateValue.on
        case CurrencySign.euro:
            rbtnEuro.state = NSControl.StateValue.on
        case CurrencySign.dollar:
            rbtnDollar.state = NSControl.StateValue.on
        default:
            NSLog("Unexpected currency was selected")
        }

        choosenCurrency = currency
        txtVatRate.doubleValue = vatRate

        numberValueFormatter.maximumFractionDigits = 2
        numberValueFormatter.decimalSeparator = "."
        txtVatRate.formatter = numberValueFormatter
    }

    @IBAction func currencyDidSelect(_ sender: NSButton) {
        choosenCurrency = sender.title
    }

    @IBAction func doneButtonPressed(_ sender: Any) {
        let enteredVatValue = txtVatRate.doubleValue

        // If changed the vat value in textfield
        if enteredVatValue != vatRate {
            defaults.set(txtVatRate.stringValue, forKey: UserDefaultsKeys.vatRate)
            NotificationCenter.default.post(name: NotificationIdentifier.updateTextFields, object: nil)
            defaults.synchronize()
        }

        // If changed the radio button selection
        if choosenCurrency != currency {
            defaults.set(choosenCurrency, forKey: UserDefaultsKeys.currency)
            NotificationCenter.default.post(name: NotificationIdentifier.updateCurrencyLabels, object: nil)
            defaults.synchronize()
        }

        self.view.window?.close()
    }
}
