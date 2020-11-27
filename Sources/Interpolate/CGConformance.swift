//
// CGConformance.swift
//
// © 2020 Wolf McNally
// https://wolfmcnally.com
// MIT License
//

import Foundation

#if canImport(CoreGraphics)
import CoreGraphics

extension CGFloat: Interpolable { }

extension CGPoint: ForwardInterpolable {
    @inlinable public func interpolate(to other: CGPoint, at t: CGFloat) -> CGPoint {
        CGPoint(simd.interpolate(to: other.simd, at: Double(t)))
    }

    @inlinable public init(_ simd: SIMD2<Double>) {
        self.init(x: simd.x, y: simd.y)
    }

    @inlinable public var simd: SIMD2<Double> {
        [Double(x), Double(y)]
    }
}

extension CGSize: ForwardInterpolable {
    @inlinable public func interpolate(to other: CGSize, at t: CGFloat) -> CGSize {
        CGSize(simd.interpolate(to: other.simd, at: Double(t)))
    }

    @inlinable public init(_ simd: SIMD2<Double>) {
        self.init(width: simd.x, height: simd.y)
    }

    @inlinable public var simd: SIMD2<Double> {
        [Double(width), Double(height)]
    }
}

extension CGRect: ForwardInterpolable {
    @inlinable public func interpolate(to other: CGRect, at t: CGFloat) -> CGRect {
        CGRect(simd.interpolate(to: other.simd, at: Double(t)))
    }

    @inlinable public init(_ simd: SIMD4<Double>) {
        self.init(x: simd[0], y: simd[1], width: simd[2], height: simd[3])
    }

    @inlinable public var simd: SIMD4<Double> {
        [Double(minX), Double(minY), Double(width), Double(height)]
    }
}
#endif
