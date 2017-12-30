//
//  Constants.swift
//  GrossNetCalculator
//
//  Created by Horváth Balázs on 2017. 12. 10..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import Foundation

struct Key {
    static let gross = "gross"
    static let net = "net"
}

struct CurrencySign {
    static let forint = "Ft"
    static let dollar = "$"
    static let euro = "€"
}

extension UserDefaults {
    struct Key {
        static let isAppAlreadyLaunchedOnce = "isAppAlreadyLaunchedOnce"
        static let vatRate = "vatRate"
        static let currency = "currency"
    }
}

struct NotificationIdentifier {
    static let updateCurrencyLabels = NSNotification.Name("currencyLabelUpdaterNotification")
    static let updateTextFields = NSNotification.Name("textfieldUpdaterNotification")
}

