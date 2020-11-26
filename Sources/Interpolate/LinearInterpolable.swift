//
// LinearInterpolable.swift
//
// © 2020 Wolf McNally
// https://wolfmcnally.com
// MIT License
//

import Foundation

/// Types that know how to use a scalar `t` to interpolate between themselves
/// and another value of the same type can implement `ForwardLinearInterpolable`.
public protocol ForwardLinearInterpolable {
    associatedtype Scalar: FloatingPoint
    func linearInterpolate(to other: Self, at t: Scalar) -> Self
}

/// Types that know 
public protocol ReverseLinearInterpolable {
    associatedtype Scalar: FloatingPoint
    func reverseLinearInterpolate(to other: Self, at t: Self) -> Scalar
}

public protocol LinearInterpolable: ForwardLinearInterpolable, ReverseLinearInterpolable { }

extension FloatingPoint {
    @inlinable public func linearInterpolate(to other: Self, at t: Self) -> Self {
        t * (other - self) + self
    }

    @inlinable public func reverseLinearInterpolate(to other: Self, at t: Self) -> Self {
        (self - t) / (self - other)
    }
}

extension Double: LinearInterpolable { }
extension Float: LinearInterpolable { }
extension Float80: LinearInterpolable { }

#if !os(macOS)
@available(iOS 14.0, *)
extension Float16: LinearInterpolable { }
#endif

#if canImport(CoreGraphics)
import CoreGraphics
extension CGFloat: LinearInterpolable { }
#endif

extension SIMD where Scalar: FloatingPoint {
    @inlinable public func linearInterpolate(to other: Self, at t: Self.Scalar) -> Self {
        t * (other - self) + self
    }
}

extension SIMD2: ForwardLinearInterpolable where Scalar: FloatingPoint { }
extension SIMD3: ForwardLinearInterpolable where Scalar: FloatingPoint { }
extension SIMD4: ForwardLinearInterpolable where Scalar: FloatingPoint { }
