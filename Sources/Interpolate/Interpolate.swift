//
// Interpolate.swift
//
// © 2020 Wolf McNally
// https://wolfmcnally.com
// MIT License
//

@inlinable public func linearInterpolate<T: ForwardLinearInterpolable, Scalar>(from a: T, to b: T) -> (_ t: Scalar) -> T where Scalar == T.Scalar {
    { a.linearInterpolate(to: b, at: $0) }
}

@inlinable public func reverseLinearInterpolate<T: ReverseLinearInterpolable, Scalar>(from a: T, to b: T) -> (_ t: T) -> Scalar where Scalar == T.Scalar {
    { a.reverseLinearInterpolate(to: b, at: $0) }
}

@inlinable public func linearInterpolate<T: ForwardLinearInterpolable, Scalar>(_ r: (T, T)) -> (_ t: Scalar) -> T where Scalar == T.Scalar {
    { r.0.linearInterpolate(to: r.1, at: $0) }
}

@inlinable public func reverseLinearInterpolate<T: ReverseLinearInterpolable, Scalar>(_ r: (T, T)) -> (_ t: T) -> Scalar where Scalar == T.Scalar {
    { r.0.reverseLinearInterpolate(to: r.1, at: $0) }
}

///
/// Interpolation-Formation Operator
///
infix operator .>. : RangeFormationPrecedence

@inlinable public func .>. <T: ForwardLinearInterpolable, Scalar>(left: T, right: T) -> (_ t: Scalar) -> T where Scalar == T.Scalar {
    linearInterpolate(from: left, to: right)
}

prefix operator .>.

@inlinable public prefix func .>. <T: ForwardLinearInterpolable, Scalar>(right: (T, T)) -> (_ t: Scalar) -> T where Scalar == T.Scalar {
    linearInterpolate(from: right.0, to: right.1)
}

///
/// Reverse-Interpolation-Formation Operator
///
infix operator .<. : RangeFormationPrecedence

@inlinable public func .<. <T: ReverseLinearInterpolable, Scalar>(left: T, right: T) -> (_ t: T) -> Scalar where Scalar == T.Scalar {
    reverseLinearInterpolate(from: left, to: right)
}

prefix operator .<.

@inlinable public prefix func .<. <T: ReverseLinearInterpolable, Scalar>(right: (T, T)) -> (_ t: T) -> Scalar where Scalar == T.Scalar {
    reverseLinearInterpolate(from: right.0, to: right.1)
}
