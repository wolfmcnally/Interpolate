//
// TestUtils.swift
//
// © 2020 Wolf McNally
// https://wolfmcnally.com
// MIT License
//

import Foundation

extension SIMD where Scalar: BinaryFloatingPoint {
    var testDescription: String {
        (self.indices.map { self[$0] }).testDescription
    }
}

extension String {
    var listWrapped: String {
        "{\(self)}"
    }
}

extension Collection {
    var listJoined: String {
        (map { String(describing: $0) }).joined(separator: ", ").listWrapped
    }
}

extension Collection where Element: BinaryFloatingPoint {
    var testDescription: String {
        (indices.map { self[$0] %% 3 }).listJoined
    }
}

func mapT<A, T>(steps: Int = 50, f: (T) -> A) -> [A] where T: BinaryFloatingPoint, T.Stride == T {
    let step = 1.0 / T(steps)
    return stride(from: 0.0, to: 1.0 + step, by: step).map { t in
        f(t)
    }
}
