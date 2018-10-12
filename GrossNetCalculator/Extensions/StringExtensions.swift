//
//  Extensions.swift
//  GrossNetCalculator
//
//  Created by Horváth Balázs on 2017. 09. 18..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import Foundation

public extension String {
    func filterNumbers(upto maxlength: Int) -> String {
        // Clear formatter's decimal spaces and invalid input, e.x. letters
        let filtered = String(self.filter { "0123456789".contains($0) })

        // Doesn't allow numbers greater than maxlength digits
        if filtered.count > maxlength {
            return String(filtered.prefix(maxlength))
        } else {
            return filtered
        }
    }
}
