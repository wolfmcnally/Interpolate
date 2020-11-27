//
// SIMDConformance.swift
//
// © 2020 Wolf McNally
// https://wolfmcnally.com
// MIT License
//

import Foundation

extension SIMD where Scalar: FloatingPoint {
    @inlinable public func interpolate(to other: Self, at t: Self.Scalar) -> Self {
        t * (other - self) + self
    }
}

extension SIMD2: ForwardInterpolable where Scalar: FloatingPoint { }
extension SIMD3: ForwardInterpolable where Scalar: FloatingPoint { }
extension SIMD4: ForwardInterpolable where Scalar: FloatingPoint { }
