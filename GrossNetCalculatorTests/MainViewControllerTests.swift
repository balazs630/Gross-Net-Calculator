//
//  MainViewControllerTests.swift
//  GrossNetCalculatorTests
//
//  Created by Horváth Balázs on 2017. 04. 01..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import XCTest

@testable import Gross_Net_Calculator
class MainViewControllerTests: XCTestCase {
    
    // system under test
    var sut: MainViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateController(withIdentifier: "MainVC") as! MainViewController
        _ = sut.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMainVC_ShouldNotBeNil() {
        XCTAssertNotNil(sut)
    }
    
    func testMainVC_WindowTitle() {
        XCTAssertEqual(sut.title, "Gross-Net Calculator")
    }
    
    func testMainVC_GrossToNetCalc() {
        sut.txtGross.intValue = 1270
        sut.grossToNetCalc()
        XCTAssertEqual(sut.txtNet.doubleValue, sut.txtGross.doubleValue / sut.vatRateMultiplier)
    }
    
    func testMainVC_NetToGrossCalc() {
        sut.txtNet.intValue = 1000
        sut.netToGrossCalc()
        XCTAssertEqual(sut.txtGross.doubleValue, sut.txtNet.doubleValue * sut.vatRateMultiplier)
    }
    
    func testMainVC_VatCalc() {
        sut.txtGross.intValue = 1270
        sut.txtNet.intValue = 1000
        sut.vatCalc()
        XCTAssertEqual(sut.txtVat.intValue, 270)
    }
    
    func testMainVC_UpdateLabels() {
        let currencyName: String = sut.defaults.object(forKey: "currency") as! String
        sut.updateCurrencyLblValues()
        XCTAssertEqual(sut.lblCurrency1.stringValue, currencyName)
        XCTAssertEqual(sut.lblCurrency2.stringValue, currencyName)
        XCTAssertEqual(sut.lblCurrency3.stringValue, currencyName)
    }
    
}
