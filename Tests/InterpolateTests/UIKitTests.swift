//
// UIKitTests.swift
//
// © 2020 Wolf McNally
// https://wolfmcnally.com
// MIT License
//

#if canImport(UIKit)
import Foundation
import XCTest
import Interpolate
import UIKit

final class UIKitTests: XCTestCase {
    func testUIColor() {
        let c1 = UIColor.red
        let c2 = UIColor.blue
        let steps = 10
        let step = 1.0 / Double(steps)
        let a = stride(from: 0.0, to: 1.0 + step, by: step).map { t in
            c1.interpolate(to: c2, at: t)
        }
        let joined = (a.map { $0.testDescription }).joined(separator: ", ")
        XCTAssertEqual("{\(joined)}", "{{1, 0, 0, 1}, {0.9, 0, 0.1, 1}, {0.8, 0, 0.2, 1}, {0.7, 0, 0.3, 1}, {0.6, 0, 0.4, 1}, {0.5, 0, 0.5, 1}, {0.4, 0, 0.6, 1}, {0.3, 0, 0.7, 1}, {0.2, 0, 0.8, 1}, {0.1, 0, 0.9, 1}, {0, 0, 1, 1}}")
    }
}

extension UIColor {
    var testDescription: String {
        simd.testDescription
    }
}
#endif
