//
// InterpolateTests.swift
//
// © 2020 Wolf McNally
// https://wolfmcnally.com
// MIT License
//

import XCTest
import Interpolate

final class InterpolateTests: XCTestCase {
    func test1() {
        let a = 100.0
        let b = 200.0
        let r = (a, b)
        XCTAssertEqual(a.linearInterpolate(to: b, at: 0.5), 150)
        XCTAssertEqual(a.reverseLinearInterpolate(to: b, at: 150), 0.5)
        XCTAssertEqual(linearInterpolate(from: a, to: b)(0.5), 150)
        XCTAssertEqual(linearInterpolate(r)(0.5), 150)
        XCTAssertEqual(reverseLinearInterpolate(from: a, to: b)(150), 0.5)
        XCTAssertEqual(reverseLinearInterpolate(r)(150), 0.5)
        XCTAssertEqual((a .>. b)(0.5), 150)
        XCTAssertEqual((a .<. b)(150), 0.5)
        XCTAssertEqual((.>.r)(0.5), 150)
        XCTAssertEqual((.<.r)(150), 0.5)
    }

    func test2() {
        let a = SIMD2<Double>(100, 200)
        let b = SIMD2<Double>(300, 400)
        let r = (a, b)
        XCTAssertEqual(a.linearInterpolate(to: b, at: 0.5), [200, 300])
        XCTAssertEqual(linearInterpolate(from: a, to: b)(0.5), [200, 300])
        XCTAssertEqual(linearInterpolate(r)(0.5), [200, 300])
        XCTAssertEqual((a .>. b)(0.5), [200, 300])
        XCTAssertEqual((.>.r)(0.5), [200, 300])
    }

    func test3() {
        let darkTurquoise = Color(r: 0, g: 0.8, b: 0.81)
        let salmon = Color(r: 0.98, g: 0.5, b: 0.45)

        let i1 = darkTurquoise .>. salmon
        XCTAssertEqual(i1(0.5).description, "(r: 0.49, g: 0.65, b: 0.63)")
    }

    func test4() {
        let darkTurquoise = SIMDColor(r: 0, g: 0.8, b: 0.81)
        let salmon = SIMDColor(r: 0.98, g: 0.5, b: 0.45)

        let i1 = darkTurquoise .>. salmon
        XCTAssertEqual(i1(0.5).description, "(r: 0.49, g: 0.65, b: 0.63)")
    }
}

struct Color : CustomStringConvertible {
    var r, g, b: Double

    private func f(_ n: Double) -> String { return String(format: "%.2f", n) }

    var description: String { "(r: \(f(r)), g: \(f(g)), b: \(f(b)))" }
}

extension Color : ForwardLinearInterpolable {
    func linearInterpolate(to other: Color, at t: Double) -> Color {
        return Color(
            r: r.linearInterpolate(to: other.r, at: t),
            g: g.linearInterpolate(to: other.g, at: t),
            b: b.linearInterpolate(to: other.b, at: t)
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

extension SIMDColor : ForwardLinearInterpolable {
    func linearInterpolate(to other: SIMDColor, at t: Double) -> SIMDColor {
        return SIMDColor(c.linearInterpolate(to: other.c, at: t))
    }
}
