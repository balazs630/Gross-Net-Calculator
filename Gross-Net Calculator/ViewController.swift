//
//  ViewController.swift
//  Gross-Net Calculator
//
//  Created by Horváth Balázs on 2016. 10. 18..
//  Copyright © 2016. Horváth Balázs. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak private var gross: NSTextField!
    @IBOutlet weak private var net: NSTextField!
    @IBOutlet weak private var vat: NSTextField!
    
    @IBOutlet weak var currencyLabel1: NSTextField!
    @IBOutlet weak var currencyLabel2: NSTextField!
    @IBOutlet weak var currencyLabel3: NSTextField!
    
    var prefs: UserDefaults = UserDefaults.standard
    var vatRateMultiplier: Double {
        return 1 + prefs.double(forKey: "vatRate") / 100
    }
    
    @IBAction func grossToNet(_ sender: Any) {
        net.doubleValue = (gross.doubleValue / vatRateMultiplier).rounded()
        calculateVat()
    }

    @IBAction func netToGross(_ sender: Any) {
        gross.doubleValue = (net.doubleValue * vatRateMultiplier).rounded()
        calculateVat()
    }
    
    func calculateVat() {
        vat.doubleValue = gross.doubleValue - net.doubleValue
    }
    
    func updateLabels() {
        currencyLabel1.stringValue = prefs.object(forKey: "currency") as! String
        currencyLabel2.stringValue = currencyLabel1.stringValue
        currencyLabel3.stringValue = currencyLabel1.stringValue
    }
    
    override func viewDidAppear() {
        updateLabels()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateLabels), name: LABEL_REFRESH, object: nil)
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
        
    }
    
}
