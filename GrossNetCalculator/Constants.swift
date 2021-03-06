//
//  Constants.swift
//  GrossNetCalculator
//
//  Created by Horváth Balázs on 2017. 12. 10..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import AppKit

struct Constants {
    static let maxNumberOfTextFieldDigits = 9
}

enum Key {
    static let gross = "gross"
    static let net = "net"
}

enum CurrencySign {
    static let forint = "Ft"
    static let dollar = "$"
    static let euro = "€"
}

extension UserDefaults {
    enum Key {
        static let isAppAlreadyLaunchedOnce = "isAppAlreadyLaunchedOnce"
        static let vatRate = "vatRate"
        static let currency = "currency"
    }
}

enum NotificationIdentifier {
    static let updateCurrencyLabels = NSNotification.Name("currencyLabelUpdaterNotification")
    static let updateTextFields = NSNotification.Name("textfieldUpdaterNotification")
}

extension NSStoryboard.Name {
    static let main = NSStoryboard.Name("Main")
}

extension NSStoryboard.SceneIdentifier {
    static let calculatorVC = NSStoryboard.SceneIdentifier("CalculatorVC")
    static let preferencesVC = NSStoryboard.SceneIdentifier("PreferencesVC")
}
