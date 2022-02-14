//
//  RoundedButton.swift
//  Calculator
//
//  Created by 이해주 on 2022/02/14.
//

import UIKit

@IBDesignable
// It Works Like Modifier in SwiftUI
class RoundedButton: UIButton {
    @IBInspectable var isRounded: Bool = false {
        didSet {
            if isRounded {
                self.layer.cornerRadius = self.frame.height / 2
            }
        }
    }
}
