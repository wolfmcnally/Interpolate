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
    func testScalar() {
        let a = 100.0
        let b = 200.0
        let r = (a, b)
        XCTAssertEqual(a.interpolate(to: b, at: 0.5), 150)
        XCTAssertEqual((0.5).interpolate(to: r), 150)
        XCTAssertEqual(a.reverseInterpolate(to: b, at: 150), 0.5)
        XCTAssertEqual((150).reverseInterpolate(from: r), 0.5)
        XCTAssertEqual(interpolate(from: a, to: b)(0.5), 150)
        XCTAssertEqual(interpolate(r)(0.5), 150)
        XCTAssertEqual(reverseInterpolate(from: a, to: b)(150), 0.5)
        XCTAssertEqual(reverseInterpolate(r)(150), 0.5)
        XCTAssertEqual((a .>. b)(0.5), 150)
        XCTAssertEqual((a .<. b)(150), 0.5)
        XCTAssertEqual((.>.r)(0.5), 150)
        XCTAssertEqual((.<.r)(150), 0.5)
    }

    func testSIMD() {
        let a = SIMD2<Double>(100, 200)
        let b = SIMD2<Double>(300, 400)
        let r = (a, b)
        XCTAssertEqual(a.interpolate(to: b, at: 0.5), [200, 300])
        XCTAssertEqual((0.5).interpolate(to: r), [200, 300])
        XCTAssertEqual(interpolate(from: a, to: b)(0.5), [200, 300])
        XCTAssertEqual(interpolate(r)(0.5), [200, 300])
        XCTAssertEqual((a .>. b)(0.5), [200, 300])
        XCTAssertEqual((.>.r)(0.5), [200, 300])
    }

    func testStruct() {
        let darkTurquoise = Color(r: 0, g: 0.8, b: 0.81)
        let salmon = Color(r: 0.98, g: 0.5, b: 0.45)

        let i1 = darkTurquoise .>. salmon
        XCTAssertEqual(i1(0.5).description, "{0.49, 0.65, 0.63}")
    }

    func testSIMDStruct() {
        let darkTurquoise = SIMDColor(r: 0, g: 0.8, b: 0.81)
        let salmon = SIMDColor(r: 0.98, g: 0.5, b: 0.45)

        let i1 = darkTurquoise .>. salmon
        XCTAssertEqual(i1(0.5).description, "{0.49, 0.65, 0.63}")
    }
}

struct Color : CustomStringConvertible {
    var r, g, b: Double

    var simd: SIMD3<Double> { [r, g, b] }

    var description: String { simd.testDescription }
}

extension Color : ForwardInterpolable {
    func interpolate(to other: Color, at t: Double) -> Color {
        return Color(
            r: r.interpolate(to: other.r, at: t),
            g: g.interpolate(to: other.g, at: t),
            b: b.interpolate(to: other.b, at: t)
        )
    }
}

struct SIMDColor : CustomStringConvertible {
    var simd: SIMD3<Double>

    init(_ simd: SIMD3<Double>) {
        self.simd = simd
    }

    init(r: Double, g: Double, b: Double) {
        self.simd = [r, g, b]
    }

    var r: Double { get { simd[0] } set { simd[0] = newValue } }
    var g: Double { get { simd[1] } set { simd[1] = newValue } }
    var b: Double { get { simd[2] } set { simd[2] = newValue } }

    var description: String { simd.testDescription }
}

extension SIMDColor : ForwardInterpolable {
    func interpolate(to other: SIMDColor, at t: Double) -> SIMDColor {
        return SIMDColor(simd.interpolate(to: other.simd, at: t))
    }
}
