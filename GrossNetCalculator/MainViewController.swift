//
//  ViewController.swift
//  Gross-Net Calculator
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
    
    let numberValueFormatter = NumberValueFormatter()
    var prefs: UserDefaults = UserDefaults.standard
    var vatRateMultiplier: Double {
        get {
            return 1 + prefs.double(forKey: "vatRate") / 100
        }
    }
    
    func grossToNetCalc() {
        txtNet.doubleValue = (txtGross.doubleValue / vatRateMultiplier).rounded()
        vatCalc()
    }

    func netToGrossCalc() {
        txtGross.doubleValue = (txtNet.doubleValue * vatRateMultiplier).rounded()
        vatCalc()
    }
    
    func vatCalc() {
        txtVat.doubleValue = txtGross.doubleValue - txtNet.doubleValue
    }
    
    override func controlTextDidChange(_ notification: Notification) {
        if notification.object as? NSTextField == self.txtGross {
            grossToNetCalc()
        } else if notification.object as? NSTextField == self.txtNet {
            netToGrossCalc()
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
        let currency: String = prefs.object(forKey: "currency") as! String
        
        lblCurrency1.stringValue = currency
        lblCurrency2.stringValue = currency
        lblCurrency3.stringValue = currency
    }
    
}
