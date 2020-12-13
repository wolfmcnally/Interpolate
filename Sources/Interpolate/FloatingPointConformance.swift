//
// FloatingPointConformance.swift
//
// © 2020 Wolf McNally
// https://wolfmcnally.com
// MIT License
//

import Foundation

extension FloatingPoint {
    @inlinable public func interpolate(to other: Self, at t: Self) -> Self {
        t * (other - self) + self
    }

    @inlinable public func interpolate(from other: Self, at t: Self) -> Self {
        (self - t) / (self - other)
    }
}

extension FloatingPoint {
    @inlinable public func interpolate<T: ForwardInterpolable>(to a: (T, T)) -> T where T.Scalar == Self {
        a.0.interpolate(to: a.1, at: self)
    }

    @inlinable public func interpolate(from a: (Self, Self)) -> Self {
        a.0.interpolate(from: a.1, at: self)
    }
}

extension Double: Interpolable { }
extension Float: Interpolable { }

#if !os(iOS)
extension Float80: Interpolable { }
#endif

#if !os(macOS) && !targetEnvironment(macCatalyst)
@available(iOS 14.0, *)
extension Float16: Interpolable { }
#endif
