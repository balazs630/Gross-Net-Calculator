//
//  ViewController.swift
//  Gross-Net Calculator
//
//  Created by Horváth Balázs on 2016. 10. 18..
//  Copyright © 2016. Horváth Balázs. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTextFieldDelegate {

    @IBOutlet weak private var gross: NSTextField!
    @IBOutlet weak private var net: NSTextField!
    @IBOutlet weak private var vat: NSTextField!
    
    @IBOutlet weak var currencyLabel1: NSTextField!
    @IBOutlet weak var currencyLabel2: NSTextField!
    @IBOutlet weak var currencyLabel3: NSTextField!
    
    let numberValueFormatter = NumberValueFormatter()
    var prefs: UserDefaults = UserDefaults.standard
    var vatRateMultiplier: Double {
        return 1 + prefs.double(forKey: "vatRate") / 100
    }
    
    func grossToNet() {
        net.doubleValue = (gross.doubleValue / vatRateMultiplier).rounded()
        calculateVat()
    }

    func netToGross() {
        gross.doubleValue = (net.doubleValue * vatRateMultiplier).rounded()
        calculateVat()
    }
    
    func calculateVat() {
        vat.doubleValue = gross.doubleValue - net.doubleValue
    }
    
    override func controlTextDidChange(_ notification: Notification) {
        if notification.object as? NSTextField == self.gross {
            grossToNet()
        } else if notification.object as? NSTextField == self.net {
            netToGross()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateLabels), name: LABEL_REFRESH, object: nil)
    }
    
    override func viewDidAppear() {
        updateLabels()
        
        view.window!.styleMask.remove(NSWindowStyleMask.resizable)
        gross.formatter = numberValueFormatter
        net.formatter = numberValueFormatter
        vat.formatter = numberValueFormatter
    }
    
    func updateLabels() {
        currencyLabel1.stringValue = prefs.object(forKey: "currency") as! String
        currencyLabel2.stringValue = currencyLabel1.stringValue
        currencyLabel3.stringValue = currencyLabel1.stringValue
    }
    
}
