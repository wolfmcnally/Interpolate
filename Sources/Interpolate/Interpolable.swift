//
// Interpolable.swift
//
// © 2020 Wolf McNally
// https://wolfmcnally.com
// MIT License
//

import Foundation

/// Types that know how to use a scalar `t` to interpolate between themselves
/// and another value of the same type can conform to `ForwardInterpolable`.
public protocol ForwardInterpolable {
    associatedtype Scalar: FloatingPoint
    func interpolate(to other: Self, at t: Scalar) -> Self
}

/// Types that know how to determine a scalar `t` from two instances
/// of themselves can conform to `ReverseInterpolable`.
public protocol ReverseInterpolable {
    associatedtype Scalar: FloatingPoint
    func interpolate(from other: Self, at t: Self) -> Scalar
}

public protocol Interpolable: ForwardInterpolable, ReverseInterpolable {
    func interpolate(from a: (Self, Self), to b: (Self, Self)) -> Scalar
}

extension Interpolable {
    @inlinable public func interpolate(from a: (Self, Self), to b: (Self, Self)) -> Self {
        let scalar = a.0.interpolate(from: a.1, at: self)
        let value = b.0.interpolate(to: b.1, at: scalar)
        return value
    }
}
