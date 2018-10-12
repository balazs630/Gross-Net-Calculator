//
//  NSTextFieldExtension.swift
//  GrossNetCalculator
//
//  Created by Horváth Balázs on 2018. 10. 13..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Cocoa

extension NSTextField {
    func moveCursorToEnd() {
        self.currentEditor()?.selectedRange = NSRange(location: Int.max, length: 0)
    }
}
