//
//  CalculatorViewController.swift
//  GrossNetCalculator
//
//  Created by Horváth Balázs on 2016. 10. 18..
//  Copyright © 2016. Horváth Balázs. All rights reserved.
//

import Cocoa

class CalculatorViewController: NSViewController {
    // MARK: Properties
    var activeTextField = Key.gross
    let defaults = UserDefaults.standard
    let numberFormatter = NumberFormatter()

    var vatRateMultiplier: Double {
        return 1 + defaults.double(forKey: UserDefaults.Key.vatRate) / 100
    }

    // MARK: Outlets
    @IBOutlet weak var txtGross: NSTextField!
    @IBOutlet weak var txtNet: NSTextField!
    @IBOutlet weak var txtVat: NSTextField!

    @IBOutlet weak var lblCurrency1: NSTextField!
    @IBOutlet weak var lblCurrency2: NSTextField!
    @IBOutlet weak var lblCurrency3: NSTextField!

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addNotificationCenterObservers()
    }

    override func viewDidAppear() {
        configureSelf()
        updateCurrencyLblValues()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Screen configuration
extension CalculatorViewController {
    private func configureSelf() {
        numberFormatter.numberStyle = .decimal
        txtGross.formatter = numberFormatter
        txtNet.formatter = numberFormatter
        txtVat.formatter = numberFormatter

        view.window!.styleMask.remove(.resizable)
    }
}

// MARK: - Calculations
extension CalculatorViewController {
    func grossToNetCalc() {
        txtGross.stringValue = txtGross.stringValue.filterNumbers(upto: Constants.maxNumberOfTextFieldDigits)
        txtNet.doubleValue = (txtGross.doubleValue / vatRateMultiplier).rounded()
        txtGross.moveCursorToEnd()
        vatCalc()
    }

    func netToGrossCalc() {
        txtNet.stringValue = txtNet.stringValue.filterNumbers(upto: Constants.maxNumberOfTextFieldDigits)
        txtGross.doubleValue = (txtNet.doubleValue * vatRateMultiplier).rounded()
        txtNet.moveCursorToEnd()
        vatCalc()
    }

    func vatCalc() {
        txtVat.doubleValue = txtGross.doubleValue - txtNet.doubleValue
    }

    // MARK: - NotificationCenter actions
    @objc func updateCurrencyLblValues() {
        // Update the currency labels placed after the textfields if the currency was changed in Preferences
        guard let currency = defaults.string(forKey: UserDefaults.Key.currency) else { return }

        lblCurrency1.stringValue = currency
        lblCurrency2.stringValue = currency
        lblCurrency3.stringValue = currency
    }

    @objc func updateTxtValues() {
        // Update the calculations if the vatRate was changed in Preferences
        if activeTextField == Key.gross && txtGross.stringValue != "" {
            grossToNetCalc()
        } else if activeTextField == Key.net && txtNet.stringValue != "" {
            netToGrossCalc()
        }
    }
}

// MARK: NotificationCenter
extension CalculatorViewController {
    private func addNotificationCenterObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateCurrencyLblValues),
                                               name: NotificationIdentifier.updateCurrencyLabels,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTxtValues),
                                               name: NotificationIdentifier.updateTextFields,
                                               object: nil)
    }
}

// MARK: - NSTextFieldDelegate methods
extension CalculatorViewController: NSTextFieldDelegate {
    func controlTextDidBeginEditing(_ notification: Notification) {
        // Called when textfield is clicked
        if notification.object as? NSTextField == self.txtGross {
            activeTextField = Key.gross
        } else if notification.object as? NSTextField == self.txtNet {
            activeTextField = Key.net
        }
    }

    func controlTextDidChange(_ notification: Notification) {
        // Called on every textfield change
        if activeTextField == Key.gross {
            grossToNetCalc()
        } else if activeTextField == Key.net {
            netToGrossCalc()
        }
    }
}
