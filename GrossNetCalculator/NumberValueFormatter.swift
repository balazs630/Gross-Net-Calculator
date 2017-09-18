//
//  NumberValueFormatter.swift
//  GrossNetCalculator
//
//  Created by Horváth Balázs on 2017. 02. 21..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//
import Foundation

class NumberValueFormatter: NumberFormatter {

    override func isPartialStringValid(_ partialString: String,
                                       newEditingString newString: AutoreleasingUnsafeMutablePointer<NSString?>?,
                                       errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        if partialString.isEmpty {
            return true
        }

        return Double(partialString) != nil
    }

    override init() {
        super.init()
        self.numberStyle = .decimal
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
