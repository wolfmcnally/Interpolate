//
// CollectionConformance.swift
//
// © 2020 Wolf McNally
// https://wolfmcnally.com
// MIT License
//

import Foundation

extension Collection where Element: ForwardInterpolable {
    public func interpolate<O: Collection, Scalar>(to other: O, at t: Scalar) -> [Element] where O.Element == Element, Scalar == Element.Scalar {
        var o = other.makeIterator()
        return map { e in
            guard let n = o.next() else { return e }
            return e.interpolate(to: n, at: t)
        }
    }
}
