//
//  Extensions.swift
//  moretomoney
//
//  Created by Ryan Haslag on 11/14/21.
//

import Foundation
import SwiftUI

//String Extensions
extension String {
    //Convert numbers into currency
    func currencyFormatting() -> String {
        if let value = Double(self) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.maximumFractionDigits = 0
            formatter.minimumFractionDigits = 0
            if let str = formatter.string(for: value) {
                return str
            }
        }
        return ""
    }
}

//Struct: Custom left side toggle allowing for price display on right
struct CustomToggle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .labelsHidden()
            .padding(.trailing, 20)
            .toggleStyle(SwitchToggleStyle(tint: Color.pink500))
    }
}

//View extensions
extension View {
    func customToggle() -> some View {
        modifier(CustomToggle())
    }
}
