//
//  ViewController.swift
//  Gross-Net Calculator
//
//  Created by Horváth Balázs on 2016. 10. 18..
//  Copyright © 2016. Horváth Balázs. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController, NSTextFieldDelegate {

    @IBOutlet weak private var txtGross: NSTextField!
    @IBOutlet weak private var txtNet: NSTextField!
    @IBOutlet weak private var txtVat: NSTextField!
    
    @IBOutlet weak var lblCurrency1: NSTextField!
    @IBOutlet weak var lblCurrency2: NSTextField!
    @IBOutlet weak var lblCurrency3: NSTextField!
    
    let numberValueFormatter = NumberValueFormatter()
    var prefs: UserDefaults = UserDefaults.standard
    var vatRateMultiplier: Double {
        return 1 + prefs.double(forKey: "vatRate") / 100
    }
    
    func grossToNet() {
        txtNet.doubleValue = (txtGross.doubleValue / vatRateMultiplier).rounded()
        calculateVat()
    }

    func netToGross() {
        txtGross.doubleValue = (txtNet.doubleValue * vatRateMultiplier).rounded()
        calculateVat()
    }
    
    func calculateVat() {
        txtVat.doubleValue = txtGross.doubleValue - txtNet.doubleValue
    }
    
    override func controlTextDidChange(_ notification: Notification) {
        if notification.object as? NSTextField == self.txtGross {
            grossToNet()
        } else if notification.object as? NSTextField == self.txtNet {
            netToGross()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUserDefaultsIfNotExist()
        NotificationCenter.default.addObserver(self, selector: #selector(updateLabels), name: LABEL_REFRESH, object: nil)
    }
    
    override func viewDidAppear() {
        updateLabels()
        
        numberValueFormatter.numberStyle = .none
        txtGross.formatter = numberValueFormatter
        txtNet.formatter = numberValueFormatter
        txtVat.formatter = numberValueFormatter
        
        view.window!.styleMask.remove(NSWindowStyleMask.resizable)
    }
    
    func setUserDefaultsIfNotExist() {
        if prefs.object(forKey: "vatRate") == nil {
            prefs.set(27, forKey: "vatRate")
        }
        if prefs.object(forKey: "currency") == nil {
            prefs.set("Ft", forKey: "currency")
        }
        prefs.synchronize()
    }
    
    func updateLabels() {
        lblCurrency1.stringValue = prefs.object(forKey: "currency") as! String
        lblCurrency2.stringValue = lblCurrency1.stringValue
        lblCurrency3.stringValue = lblCurrency1.stringValue
    }
    
}
