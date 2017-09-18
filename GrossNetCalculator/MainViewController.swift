//
//  MainViewController.swift
//  GrossNetCalculator
//
//  Created by Horváth Balázs on 2016. 10. 18..
//  Copyright © 2016. Horváth Balázs. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController, NSTextFieldDelegate {

    @IBOutlet weak var txtGross: NSTextField!
    @IBOutlet weak var txtNet: NSTextField!
    @IBOutlet weak var txtVat: NSTextField!

    @IBOutlet weak var lblCurrency1: NSTextField!
    @IBOutlet weak var lblCurrency2: NSTextField!
    @IBOutlet weak var lblCurrency3: NSTextField!

    var activeTextField: String = "gross"
    var defaults: UserDefaults = UserDefaults.standard
    let numberFormatter = NumberFormatter()
    let maxDigits = 9

    var vatRateMultiplier: Double {
        return 1 + defaults.double(forKey: "vatRate") / 100
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateCurrencyLblValues),
                                               name: NotificationIdentifier.updateCurrencyLabels, object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTxtValues),
                                               name: NotificationIdentifier.updateTextFields, object: nil)
    }

    override func viewDidAppear() {
        updateCurrencyLblValues()

        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        txtGross.formatter = numberFormatter
        txtNet.formatter = numberFormatter
        txtVat.formatter = numberFormatter

        view.window!.styleMask.remove(NSWindowStyleMask.resizable)
    }

    func grossToNetCalc() {
        txtGross.stringValue = txtGross.stringValue.filterNumbers(maxDigits)
        txtNet.doubleValue = (txtGross.doubleValue / vatRateMultiplier).rounded()
        vatCalc()
    }

    func netToGrossCalc() {
        txtNet.stringValue = txtNet.stringValue.filterNumbers(maxDigits)
        txtGross.doubleValue = (txtNet.doubleValue * vatRateMultiplier).rounded()
        vatCalc()
    }

    func vatCalc() {
        txtVat.doubleValue = txtGross.doubleValue - txtNet.doubleValue
    }

    override func controlTextDidChange(_ notification: Notification) {
        // Called on every textfield change
        if notification.object as? NSTextField == self.txtGross {
            grossToNetCalc()
        } else if notification.object as? NSTextField == self.txtNet {
            netToGrossCalc()
        }
        // If the text is selected, a keypress would remove the text in the textfield
        deselectTextFieldContent()
    }

    override func controlTextDidBeginEditing(_ notification: Notification) {
        // Called when textfield is clicked
        if notification.object as? NSTextField == self.txtGross {
            activeTextField = "gross"
        } else if notification.object as? NSTextField == self.txtNet {
            activeTextField = "net"
        }
    }

    private func deselectTextFieldContent() {
        // Simulate Right Arrow keypress
        let NSKeyCodeRightArrow: UInt16 = 124

        let keyDownEvent = CGEvent(keyboardEventSource: nil, virtualKey: NSKeyCodeRightArrow, keyDown: true)
        keyDownEvent?.flags = CGEventFlags.maskCommand
        keyDownEvent?.post(tap: CGEventTapLocation.cghidEventTap)

        let keyUpEvent = CGEvent(keyboardEventSource: nil, virtualKey: NSKeyCodeRightArrow, keyDown: false)
        keyUpEvent?.flags = CGEventFlags.maskCommand
        keyUpEvent?.post(tap: CGEventTapLocation.cghidEventTap)
    }

    func updateCurrencyLblValues() {
        // Update the currency labels placed after the textfields
        let currency: String = defaults.object(forKey: "currency") as! String

        lblCurrency1.stringValue = currency
        lblCurrency2.stringValue = currency
        lblCurrency3.stringValue = currency
    }

    func updateTxtValues() {
        // Update the calculations if the vatRate was changed in Preferences
        if activeTextField == "gross" && txtGross.stringValue != "" {
            grossToNetCalc()
        } else if activeTextField == "net" && txtNet.stringValue != "" {
            netToGrossCalc()
        }
    }

}
