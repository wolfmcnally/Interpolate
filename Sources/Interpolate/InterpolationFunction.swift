//
// InterpolationFunction.swift
//
// © 2020 Wolf McNally
// https://wolfmcnally.com
// MIT License
//

@inlinable public func interpolate<T: ForwardInterpolable, Scalar>(from a: T, to b: T) -> (_ t: Scalar) -> T where Scalar == T.Scalar {
    { a.interpolate(to: b, at: $0) }
}

@inlinable public func reverseInterpolate<T: ReverseInterpolable, Scalar>(from a: T, to b: T) -> (_ t: T) -> Scalar where Scalar == T.Scalar {
    { a.reverseInterpolate(to: b, at: $0) }
}

@inlinable public func interpolate<T: ForwardInterpolable, Scalar>(_ r: (T, T)) -> (_ t: Scalar) -> T where Scalar == T.Scalar {
    { r.0.interpolate(to: r.1, at: $0) }
}

@inlinable public func reverseInterpolate<T: ReverseInterpolable, Scalar>(_ r: (T, T)) -> (_ t: T) -> Scalar where Scalar == T.Scalar {
    { r.0.reverseInterpolate(to: r.1, at: $0) }
}

///
/// Interpolation-Formation Operator
///
infix operator .>. : RangeFormationPrecedence

@inlinable public func .>. <T: ForwardInterpolable, Scalar>(left: T, right: T) -> (_ t: Scalar) -> T where Scalar == T.Scalar {
    interpolate(from: left, to: right)
}

prefix operator .>.

@inlinable public prefix func .>. <T: ForwardInterpolable, Scalar>(right: (T, T)) -> (_ t: Scalar) -> T where Scalar == T.Scalar {
    interpolate(from: right.0, to: right.1)
}

///
/// Reverse-Interpolation-Formation Operator
///
infix operator .<. : RangeFormationPrecedence

@inlinable public func .<. <T: ReverseInterpolable, Scalar>(left: T, right: T) -> (_ t: T) -> Scalar where Scalar == T.Scalar {
    reverseInterpolate(from: left, to: right)
}

prefix operator .<.

@inlinable public prefix func .<. <T: ReverseInterpolable, Scalar>(right: (T, T)) -> (_ t: T) -> Scalar where Scalar == T.Scalar {
    reverseInterpolate(from: right.0, to: right.1)
}
