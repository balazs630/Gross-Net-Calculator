//
//  PreferencesViewController.swift
//  GrossNetCalculator
//
//  Created by Horváth Balázs on 2017. 04. 13.
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import Cocoa

class PreferencesViewController: NSViewController {

    // MARK: Properties
    let defaults = UserDefaults.standard
    let numberValueFormatter = NumberValueFormatter()
    var choosenCurrency = ""

    var currency: String {
        return defaults.string(forKey: UserDefaults.Key.currency)!
    }

    var vatRate: Double {
        return defaults.double(forKey: UserDefaults.Key.vatRate)
    }

    // MARK: Outlets
    @IBOutlet weak var txtVatRate: NSTextField!
    @IBOutlet weak var rbtnFt: NSButton!
    @IBOutlet weak var rbtnEuro: NSButton!
    @IBOutlet weak var rbtnDollar: NSButton!

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    // MARK: - View setups
    private func setUpView() {
        configureRadioButtons()
        configureVatRateTextField()
    }

    private func configureRadioButtons() {
        let onState = NSControl.StateValue.on

        switch currency {
        case CurrencySign.forint:
            rbtnFt.state = onState
        case CurrencySign.euro:
            rbtnEuro.state = onState
        case CurrencySign.dollar:
            rbtnDollar.state = onState
        default:
            NSLog("Unexpected currency was selected")
        }

        choosenCurrency = currency
    }

    private func configureVatRateTextField() {
        txtVatRate.doubleValue = vatRate

        numberValueFormatter.maximumFractionDigits = 2
        numberValueFormatter.decimalSeparator = "."
        txtVatRate.formatter = numberValueFormatter
    }

    // MARK: - Actions
    @IBAction func currencyDidSelect(_ sender: NSButton) {
        choosenCurrency = sender.title
    }

    @IBAction func doneButtonPressed(_ sender: Any) {
        handleVatTextFieldChanges()
        handleRadioButtonStateChanges()

        self.view.window?.close()
    }

    private func handleVatTextFieldChanges() {
        if txtVatRate.doubleValue != vatRate {
            defaults.set(txtVatRate.stringValue, forKey: UserDefaults.Key.vatRate)
            NotificationCenter.default.post(name: NotificationIdentifier.updateTextFields, object: nil)
            defaults.synchronize()
        }
    }

    private func handleRadioButtonStateChanges () {
        if choosenCurrency != currency {
            defaults.set(choosenCurrency, forKey: UserDefaults.Key.currency)
            NotificationCenter.default.post(name: NotificationIdentifier.updateCurrencyLabels, object: nil)
            defaults.synchronize()
        }
    }
}
