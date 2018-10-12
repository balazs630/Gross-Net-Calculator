//
//  AppDelegate.swift
//  GrossNetCalculator
//
//  Created by Horváth Balázs on 2016. 10. 18..
//  Copyright © 2016. Horváth Balázs. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let defaults = UserDefaults.standard

        if defaults.object(forKey: UserDefaults.Key.isAppAlreadyLaunchedOnce) == nil {
            // First launch
            let firstTimeLaunchDefaults: [String: Any] = [
                UserDefaults.Key.isAppAlreadyLaunchedOnce: true,
                UserDefaults.Key.vatRate: 27,
                UserDefaults.Key.currency: CurrencySign.forint
            ]

            firstTimeLaunchDefaults.forEach {
                defaults.set($0.value, forKey: $0.key)
            }

            defaults.synchronize()
        }
    }
}
