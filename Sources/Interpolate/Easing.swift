//
// Easing.swift
//
// © 2020 Wolf McNally
// https://wolfmcnally.com
// MIT License
//

import Foundation
import Numerics

public struct Easing {

    // MARK: - Linear

    @inlinable public static func linear<Scalar: Real> (_ t: Scalar) -> Scalar {
        t
    }

    @inlinable public static func linear<T: ForwardInterpolable, Scalar>(_ f: @escaping (_ t: Scalar) -> T) -> (_ t: Scalar) -> T where Scalar == T.Scalar {
        f
    }

    // MARK: - Ease

    @inlinable public static func easeIn<Scalar: Real> (_ t: Scalar) -> Scalar {
        1 - .cos(t * .pi / 2)
    }

    public static func easeIn<T: ForwardInterpolable, Scalar>(_ f: @escaping (_ t: Scalar) -> T) -> (_ t: Scalar) -> T where T.Scalar == Scalar, Scalar: Real {
        { f(easeIn($0)) }
    }

    @inlinable public static func easeOut<Scalar: Real> (_ t: Scalar) -> Scalar {
        .sin(t * .pi / 2)
    }

    public static func easeOut<T: ForwardInterpolable, Scalar>(_ f: @escaping (_ t: Scalar) -> T) -> (_ t: Scalar) -> T where T.Scalar == Scalar, Scalar: Real {
        { f(easeOut($0)) }
    }

    @inlinable public static func easeInOut<Scalar: Real> (_ t: Scalar) -> Scalar {
        let a = Scalar.sin(t * .pi / 2)
        return a * a
    }

    public static func easeInOut<T: ForwardInterpolable, Scalar>(_ f: @escaping (_ t: Scalar) -> T) -> (_ t: Scalar) -> T where T.Scalar == Scalar, Scalar: Real {
        { f(easeInOut($0)) }
    }

    // MARK: - Exponential

    @inlinable public static func exponentialIn<Scalar: Real> (_ t: Scalar) -> Scalar {
        .pow(2, 10 * (t - 1))
    }

    public static func exponentialIn<T: ForwardInterpolable, Scalar>(_ f: @escaping (_ t: Scalar) -> T) -> (_ t: Scalar) -> T where T.Scalar == Scalar, Scalar: Real {
        { f(exponentialIn($0)) }
    }

    @inlinable public static func exponentialOut<Scalar: Real> (_ t: Scalar) -> Scalar {
        1 - .pow(2, -10 * t)
    }

    public static func exponentialOut<T: ForwardInterpolable, Scalar>(_ f: @escaping (_ t: Scalar) -> T) -> (_ t: Scalar) -> T where T.Scalar == Scalar, Scalar: Real {
        { f(exponentialOut($0)) }
    }

    @inlinable public static func exponentialInOut<Scalar: Real> (_ t: Scalar) -> Scalar {
        let oneHalf = Scalar(sign: .plus, exponent: -1, significand: 1)
        if t < oneHalf {
            return exponentialIn(2 * t) / 2
        } else {
            return exponentialOut(2 * t - 1) / 2 + oneHalf
        }
    }

    public static func exponentialInOut<T: ForwardInterpolable, Scalar>(_ f: @escaping (_ t: Scalar) -> T) -> (_ t: Scalar) -> T where T.Scalar == Scalar, Scalar: Real {
        { f(exponentialInOut($0)) }
    }

    // MARK: - Back

    @inlinable public static func backIn<Scalar: BinaryFloatingPoint> (_ t: Scalar) -> Scalar {
        t * t * (2.70158 * t - 1.70158)
    }

    public static func backIn<T: ForwardInterpolable, Scalar>(_ f: @escaping (_ t: Scalar) -> T) -> (_ t: Scalar) -> T where T.Scalar == Scalar, Scalar: BinaryFloatingPoint {
        { f(backIn($0)) }
    }

    @inlinable public static func backOut<Scalar: BinaryFloatingPoint> (_ t: Scalar) -> Scalar {
        let t1 = t - 1
        return ((1.70158 + 2.70158 * t1) * t1 * t1) / 2.0
    }

    public static func backOut<T: ForwardInterpolable, Scalar>(_ f: @escaping (_ t: Scalar) -> T) -> (_ t: Scalar) -> T where T.Scalar == Scalar, Scalar: BinaryFloatingPoint {
        { f(backOut($0)) }
    }

    @inlinable public static func backInOut<Scalar: BinaryFloatingPoint> (_ t: Scalar) -> Scalar {
        let oneHalf = Scalar(sign: .plus, exponent: -1, significand: 1)
        if t < oneHalf {
            return backIn(2 * t) / 2
        } else {
            return backOut(2 * t - 1) + 1
        }
    }

    public static func backInOut<T: ForwardInterpolable, Scalar>(_ f: @escaping (_ t: Scalar) -> T) -> (_ t: Scalar) -> T where T.Scalar == Scalar, Scalar: BinaryFloatingPoint {
        { f(backInOut($0)) }
    }

    // MARK: - Bounce

    private static func bounceTime<Scalar: BinaryFloatingPoint>(_ t: Scalar) -> Scalar {
        if t < 1 / 2.75 {
            return 7.5625 * t * t
        } else if t < 2 / 2.75 {
            let t2 = t - 1.5 / 2.75
            return 7.5625 * t2 * t2 + 0.75
        } else if t < 2.5 / 2.75 {
            let t2 = t - 2.25 / 2.75
            return 7.5625 * t2 * t2 + 0.9375
        } else {
            let t2 = t - 2.625 / 2.75
            return 7.5625 * t2 * t2 + 0.984375
        }
    }

    public static func bounceIn<Scalar: BinaryFloatingPoint> (_ t: Scalar) -> Scalar {
        1 - bounceTime(1 - t)
    }

    public static func bounceIn<T: ForwardInterpolable, Scalar>(_ f: @escaping (_ t: Scalar) -> T) -> (_ t: Scalar) -> T where T.Scalar == Scalar, Scalar: BinaryFloatingPoint {
        { f(bounceIn($0)) }
    }

    public static func bounceOut<Scalar: BinaryFloatingPoint> (_ t: Scalar) -> Scalar {
        bounceTime(t)
    }

    public static func bounceOut<T: ForwardInterpolable, Scalar>(_ f: @escaping (_ t: Scalar) -> T) -> (_ t: Scalar) -> T where T.Scalar == Scalar, Scalar: BinaryFloatingPoint {
        { f(bounceOut($0)) }
    }

    @inlinable public static func bounceInOut<Scalar: BinaryFloatingPoint> (_ t: Scalar) -> Scalar {
        let oneHalf = Scalar(sign: .plus, exponent: -1, significand: 1)
        if t < oneHalf {
            return bounceIn(2 * t) / 2
        } else {
            return bounceOut(2 * t - 1) / 2 + oneHalf
        }
    }

    public static func bounceInOut<T: ForwardInterpolable, Scalar>(_ f: @escaping (_ t: Scalar) -> T) -> (_ t: Scalar) -> T where T.Scalar == Scalar, Scalar: BinaryFloatingPoint {
        { f(bounceInOut($0)) }
    }

    // MARK: - Elastic

    public static func elasticIn<Scalar: Real>(_ t: Scalar) -> Scalar {
        let t2 = t - 1
        let kperiod = Scalar(3) / Scalar(10)
        let s = kperiod / 4
        let a1: Scalar = -(.pow(2, t2 * Scalar(10)))
        let a2: Scalar = .sin((t2 - s) * 2 * .pi / kperiod)
        return a1 * a2
    }

    public static func elasticIn<T: ForwardInterpolable, Scalar>(_ f: @escaping (_ t: Scalar) -> T) -> (_ t: Scalar) -> T where T.Scalar == Scalar, Scalar: Real {
        { f(elasticIn($0)) }
    }

    public static func elasticOut<Scalar: Real> (_ t: Scalar) -> Scalar {
        let kperiod = Scalar(3) / Scalar(10)
        let s = kperiod / 4
        let a1: Scalar = .pow(2, -10 * t)
        let a2: Scalar = .sin((t - s) * 2 * .pi / kperiod)
        return a1 * a2 + 1
    }

    public static func elasticOut<T: ForwardInterpolable, Scalar>(_ f: @escaping (_ t: Scalar) -> T) -> (_ t: Scalar) -> T where T.Scalar == Scalar, Scalar: Real {
        { f(elasticOut($0)) }
    }

    @inlinable public static func elasticInOut<Scalar: Real> (_ t: Scalar) -> Scalar {
        let oneHalf = Scalar(sign: .plus, exponent: -1, significand: 1)
        if t < oneHalf {
            return elasticIn(2 * t) / 2
        } else {
            return elasticOut(2 * t - 1) / 2 + oneHalf
        }
    }

    public static func elasticInOut<T: ForwardInterpolable, Scalar>(_ f: @escaping (_ t: Scalar) -> T) -> (_ t: Scalar) -> T where T.Scalar == Scalar, Scalar: Real {
        { f(elasticInOut($0)) }
    }
}
