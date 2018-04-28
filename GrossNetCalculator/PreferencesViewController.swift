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
        // Do view setup here.
    }

    override func viewDidAppear() {
        setUpView()
    }

    // MARK: - View setups
    private func setUpView() {
        configureRadioButtons()
        configureVatRateTextField()
    }

    private func configureRadioButtons() {
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
        if vatTextFieldDidChange() {
            defaults.set(txtVatRate.stringValue, forKey: UserDefaults.Key.vatRate)
            NotificationCenter.default.post(name: NotificationIdentifier.updateTextFields, object: nil)
            defaults.synchronize()
        }

        if radioButtonStateDidChange() {
            defaults.set(choosenCurrency, forKey: UserDefaults.Key.currency)
            NotificationCenter.default.post(name: NotificationIdentifier.updateCurrencyLabels, object: nil)
            defaults.synchronize()
        }

        self.view.window?.close()
    }

    private func vatTextFieldDidChange () -> Bool {
        return txtVatRate.doubleValue != vatRate ? true : false
    }

    private func radioButtonStateDidChange () -> Bool {
        return choosenCurrency != currency ? true : false
    }
}
