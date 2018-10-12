//
//  NumberValueFormatter.swift
//  GrossNetCalculator
//
//  Created by Horváth Balázs on 2017. 02. 21..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import Foundation

class NumberValueFormatter: NumberFormatter {
    // MARK: - View lifecycle
    override init() {
        super.init()
        configureSelf()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func configureSelf() {
        self.numberStyle = .decimal
    }

    // MARK: Formatter configuration
    override func isPartialStringValid(_ partialString: String,
                                       newEditingString newString: AutoreleasingUnsafeMutablePointer<NSString?>?,
                                       errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        if partialString.isEmpty {
            return true
        }

        return Double(partialString) != nil
    }
}
