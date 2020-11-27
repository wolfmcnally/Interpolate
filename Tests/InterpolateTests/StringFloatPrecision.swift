//
// StringFloatPrecision.swift
//
// © 2020 Wolf McNally
// https://wolfmcnally.com
// MIT License
//

import Foundation

extension String {
    init<F: BinaryFloatingPoint>(_ value: F, precision: Int) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = false
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = precision
        self.init(formatter.string(from: NSNumber(value: Double(value)))!)
    }
}

precedencegroup AttributeAssignmentPrecedence {
    associativity: left
    higherThan: AssignmentPrecedence
    lowerThan: ComparisonPrecedence
}

infix operator %% : AttributeAssignmentPrecedence

func %% <F: BinaryFloatingPoint>(left: F, right: Int) -> String {
    return String(left, precision: right)
}
