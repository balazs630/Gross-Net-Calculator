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
    let maxDigits = 9

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

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateCurrencyLblValues),
                                               name: NotificationIdentifier.updateCurrencyLabels,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTxtValues),
                                               name: NotificationIdentifier.updateTextFields,
                                               object: nil)
    }

    override func viewDidAppear() {
        updateCurrencyLblValues()

        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        txtGross.formatter = numberFormatter
        txtNet.formatter = numberFormatter
        txtVat.formatter = numberFormatter

        view.window!.styleMask.remove(NSWindow.StyleMask.resizable)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Calculations
    func grossToNetCalc() {
        txtGross.stringValue = txtGross.stringValue.filterNumbers(upto: maxDigits)
        txtNet.doubleValue = (txtGross.doubleValue / vatRateMultiplier).rounded()
        vatCalc()
    }

    func netToGrossCalc() {
        txtNet.stringValue = txtNet.stringValue.filterNumbers(upto: maxDigits)
        txtGross.doubleValue = (txtNet.doubleValue * vatRateMultiplier).rounded()
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

// MARK: - TextField change methods
extension CalculatorViewController: NSTextFieldDelegate {
    override func controlTextDidChange(_ notification: Notification) {
        // Called on every textfield change
        if notification.object as? NSTextField == self.txtGross {
            grossToNetCalc()
        } else if notification.object as? NSTextField == self.txtNet {
            netToGrossCalc()
        }
        // If the whole text is selected, a new keypress would remove the text in the textfield
        deselectTextFieldContent()
    }

    override func controlTextDidBeginEditing(_ notification: Notification) {
        // Called when textfield is clicked
        if notification.object as? NSTextField == self.txtGross {
            activeTextField = Key.gross
        } else if notification.object as? NSTextField == self.txtNet {
            activeTextField = Key.net
        }
    }

    private func deselectTextFieldContent() {
        // HACK: Simulate Right Arrow keypress
        let NSKeyCodeRightArrow: UInt16 = 124

        let keyDownEvent = CGEvent(keyboardEventSource: nil, virtualKey: NSKeyCodeRightArrow, keyDown: true)
        keyDownEvent?.flags = CGEventFlags.maskCommand
        keyDownEvent?.post(tap: CGEventTapLocation.cghidEventTap)

        let keyUpEvent = CGEvent(keyboardEventSource: nil, virtualKey: NSKeyCodeRightArrow, keyDown: false)
        keyUpEvent?.flags = CGEventFlags.maskCommand
        keyUpEvent?.post(tap: CGEventTapLocation.cghidEventTap)
    }
}
