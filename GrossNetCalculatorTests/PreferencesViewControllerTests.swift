//
//  PreferencesViewControllerTests.swift
//  GrossNetCalculator
//
//  Created by Horváth Balázs on 2017. 04. 13..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import XCTest

@testable import Gross_Net_Calculator
class PreferencesViewControllerTests: XCTestCase {

    // System under test
    var sut: PreferencesViewController!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = NSStoryboard(name: NSStoryboard.Name.main, bundle: nil)
        sut = storyboard.instantiateController(withIdentifier:
            NSStoryboard.SceneIdentifier.preferencesVC) as? PreferencesViewController

        _ = sut.view
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testPreferencesVC_ShouldNotBeNil() {
        XCTAssertNotNil(sut)
    }

    func testPreferencesVC_WindowTitle() {
        XCTAssertEqual(sut.title, "Preferences")
    }

    func testPreferencesVC_OnlyOneRadioButtonStateShouldBeSelected() {
        var counter = 0
        var radioButtons = [NSButton]()

        radioButtons.append(sut.rbtnFt)
        radioButtons.append(sut.rbtnEuro)
        radioButtons.append(sut.rbtnDollar)

        for radiobutton in radioButtons where radiobutton.state.rawValue == 1 {
            counter += 1
        }

        XCTAssertEqual(counter, 1)
    }

}
