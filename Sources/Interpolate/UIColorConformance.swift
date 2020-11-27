//
//  UIColorConformance.swift
//
// © 2020 Wolf McNally
// https://wolfmcnally.com
// MIT License
//

import Foundation

#if canImport(UIKit)
import UIKit

extension UIColor {
    public convenience init(_ c: SIMD4<Double>) {
        self.init(red: CGFloat(c[0]), green: CGFloat(c[1]), blue: CGFloat(c[2]), alpha: CGFloat(c[3]))
    }

    public var simd: SIMD4<Double> {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return [Double(r), Double(g), Double(b), Double(a)]
    }
}

/// `UIColor` cannot conform to `ForwardInterpolable`, because it is a non-final class.
/// `interpolate(to:at:)` has to take and return an instance of the exact same type, but
/// since `UIColor` is a "class cluster" it cannot be guaranteed that the exact subtype
/// of the `UIColor` you pass in will be the same as the subtype the `UIColor` constructor
/// actually produces.
///
/// `interpolate(to:at:)` is still provided here, but not the `ForwardInterpolable` conformance.

extension UIColor {
    public func interpolate(to other: UIColor, at t: Double) -> UIColor {
        UIColor(simd.interpolate(to: other.simd, at: t))
    }
}
#endif
