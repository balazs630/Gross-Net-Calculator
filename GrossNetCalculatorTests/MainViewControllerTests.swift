//
//  GrossNetCalculatorTests.swift
//  GrossNetCalculatorTests
//
//  Created by Horváth Balázs on 2017. 04. 01..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import XCTest

@testable import GrossNetCalculator
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
    
    func testGrossToNetCalc() {
        sut.txtGross.intValue = 1270
        sut.grossToNetCalc()
        XCTAssertEqual(sut.txtNet.doubleValue, sut.txtGross.doubleValue / sut.vatRateMultiplier)
    }
    
    func testNetToGrossCalc() {
        sut.txtNet.intValue = 1000
        sut.netToGrossCalc()
        XCTAssertEqual(sut.txtGross.doubleValue, sut.txtNet.doubleValue * sut.vatRateMultiplier)
    }
    
    func testVatCalc() {
        sut.txtGross.intValue = 1270
        sut.txtNet.intValue = 1000
        sut.vatCalc()
        XCTAssertEqual(sut.txtVat.intValue, 270)
    }
    
    func testUpdateLabels() {
        let currencyName: String = sut.prefs.object(forKey: "currency") as! String
        sut.updateLabels()
        XCTAssertEqual(sut.lblCurrency1.stringValue, currencyName)
        XCTAssertEqual(sut.lblCurrency2.stringValue, currencyName)
        XCTAssertEqual(sut.lblCurrency3.stringValue, currencyName)
    }
    
}
