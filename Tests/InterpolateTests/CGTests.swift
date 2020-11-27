//
// CGTests.swift
//
// © 2020 Wolf McNally
// https://wolfmcnally.com
// MIT License
//

#if canImport(CoreGraphics)
import XCTest
import Interpolate
import CoreGraphics

final class CGTests: XCTestCase {
    func testPoint() {
        let p1 = CGPoint([100, 200])
        let p2 = CGPoint([-400, 500])
        XCTAssertEqual((mapT(steps: 10) { t in p1.interpolate(to: p2, at: t).simd.testDescription }).listJoined, "{{100, 200}, {50, 230}, {0, 260}, {-50, 290}, {-100, 320}, {-150, 350}, {-200, 380}, {-250, 410}, {-300, 440}, {-350, 470}, {-400, 500}}")
    }

    func testSize() {
        let s1 = CGSize([100, 200])
        let s2 = CGSize([-400, 500])
        XCTAssertEqual((mapT(steps: 10) { t in s1.interpolate(to: s2, at: t).simd.testDescription }).listJoined, "{{100, 200}, {50, 230}, {0, 260}, {-50, 290}, {-100, 320}, {-150, 350}, {-200, 380}, {-250, 410}, {-300, 440}, {-350, 470}, {-400, 500}}")
    }

    func testRect() {
        let r1 = CGRect([100, 200, 300, 400])
        let r2 = CGRect([-400, 500, 500, 100])
        XCTAssertEqual((mapT(steps: 10) { t in r1.interpolate(to: r2, at: t).simd.testDescription }).listJoined, "{{100, 200, 300, 400}, {50, 230, 320, 370}, {0, 260, 340, 340}, {-50, 290, 360, 310}, {-100, 320, 380, 280}, {-150, 350, 400, 250}, {-200, 380, 420, 220}, {-250, 410, 440, 190}, {-300, 440, 460, 160}, {-350, 470, 480, 130}, {-400, 500, 500, 100}}")
    }
}

extension CGPoint {
    var testDescription: String { simd.testDescription }
}

extension CGSize {
    var testDescription: String { simd.testDescription }
}

extension CGRect {
    var testDescription: String { simd.testDescription }
}

#endif
