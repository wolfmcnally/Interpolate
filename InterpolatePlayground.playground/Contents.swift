//
// InterpolatePlayground.swift
//
// © 2020 Wolf McNally
// https://wolfmcnally.com
// MIT License
//

import Foundation
import Interpolate

struct Color : CustomStringConvertible {
    var r, g, b: Double

    private func f(_ n: Double) -> String { return String(format: "%.2f", n) }

    var description: String { "(r: \(f(r)), g: \(f(g)), b: \(f(b)))" }
}

extension Color : ForwardInterpolable {
    func interpolate(_ other: Color, using t: Double) -> Color {
        return Color(
            r: r.interpolate(other.r, using: t),
            g: g.interpolate(other.g, using: t),
            b: b.interpolate(other.b, using: t)
        )
    }
}

struct SIMDColor : CustomStringConvertible {
    var c: SIMD3<Double>

    init(_ c: SIMD3<Double>) {
        self.c = c
    }

    init(r: Double, g: Double, b: Double) {
        self.c = [r, g, b]
    }

    var r: Double { get { c[0] } set { c[0] = newValue } }
    var g: Double { get { c[1] } set { c[1] = newValue } }
    var b: Double { get { c[2] } set { c[2] = newValue } }

    private func f(_ n: Double) -> String { return String(format: "%.2f", n) }

    var description: String { "(r: \(f(r)), g: \(f(g)), b: \(f(b)))" }
}

extension SIMDColor : ForwardInterpolable {
    func interpolate(_ other: SIMDColor, using t: Double) -> SIMDColor {
        return SIMDColor(c.interpolate(other.c, using: t))
    }
}

func testColor() {
    let darkTurquoise = Color(r: 0, g: 0.8, b: 0.81)
    let salmon = Color(r: 0.98, g: 0.5, b: 0.45)
    let i1 = interpolate(darkTurquoise, salmon)

    for t in stride(from: 0.0, to: 1.1, by: 0.1) {
        print(String(format: "%.1f", t) + ": " + i1(t).description)
    }
}

func testSIMDColor() {
    let darkTurquoise = SIMDColor(r: 0, g: 0.8, b: 0.81)
    let salmon = SIMDColor(r: 0.98, g: 0.5, b: 0.45)
    let i1 = interpolate(darkTurquoise, salmon)

    for t in stride(from: 0.0, to: 1.1, by: 0.1) {
        print(String(format: "%.1f", t) + ": " + i1(t).description)
    }
}

let a = interpolate(0, 100)
a(0.5)
let b = reverseInterpolate(0, 100)
b(50)

testColor()
