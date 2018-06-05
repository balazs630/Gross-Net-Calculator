//
//  CalculatorViewControllerTests.swift
//  GrossNetCalculatorTests
//
//  Created by Horváth Balázs on 2017. 04. 01..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import XCTest

@testable import Gross_Net_Calculator
class CalculatorViewControllerTests: XCTestCase {

    // System under test
    var sut: CalculatorViewController!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = NSStoryboard(name: NSStoryboard.Name.main, bundle: nil)
        sut = storyboard.instantiateController(withIdentifier:
            NSStoryboard.SceneIdentifier.calculatorVC) as? CalculatorViewController

        _ = sut.view
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testCalculatorVCShouldNotBeNil() {
        XCTAssertNotNil(sut)
    }

    func testCalculatorVCWindowTitle() {
        XCTAssertEqual(sut.title, "Gross-Net Calculator")
    }

    func testCalculatorVCGrossToNetCalc() {
        sut.txtGross.intValue = 1270
        sut.grossToNetCalc()
        XCTAssertEqual(sut.txtNet.doubleValue, sut.txtGross.doubleValue / sut.vatRateMultiplier)
    }

    func testCalculatorVCNetToGrossCalc() {
        sut.txtNet.intValue = 1000
        sut.netToGrossCalc()
        XCTAssertEqual(sut.txtGross.doubleValue, sut.txtNet.doubleValue * sut.vatRateMultiplier)
    }

    func testCalculatorVCVatCalc() {
        sut.txtGross.intValue = 1270
        sut.txtNet.intValue = 1000
        sut.vatCalc()
        XCTAssertEqual(sut.txtVat.intValue, 270)
    }

    func testCalculatorVCUpdateLabels() {
        guard let currencyName = sut.defaults.object(forKey: "currency") as? String else { return }
        sut.updateCurrencyLblValues()
        XCTAssertEqual(sut.lblCurrency1.stringValue, currencyName)
        XCTAssertEqual(sut.lblCurrency2.stringValue, currencyName)
        XCTAssertEqual(sut.lblCurrency3.stringValue, currencyName)
    }

}
