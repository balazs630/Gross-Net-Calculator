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
        // Insert code here to initialize your application
        
        let defaults = UserDefaults.standard
        
        if defaults.object(forKey: UserDefaultsKeys.isAppAlreadyLaunchedOnce) == nil {
            // First launch
            
            let firstTimeLaunchDefaults: [String : Any] = [
                UserDefaultsKeys.isAppAlreadyLaunchedOnce: true,
                UserDefaultsKeys.vatRate: 27,
                UserDefaultsKeys.currency: CurrencySign.forint
            ]
            
            for item in firstTimeLaunchDefaults {
                defaults.set(item.value, forKey: item.key)
            }
            
            defaults.synchronize()
        }
        
    }
    
}
