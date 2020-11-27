//
// CollectionTest.swift
//
// © 2020 Wolf McNally
// https://wolfmcnally.com
// MIT License
//

import XCTest
import Interpolate

final class CollectionTest: XCTestCase {
    func test1() {
        let a1 = [1.0, 2.0, 3.0]
        let a2 = [6.0, 3.0, 1.0]
        XCTAssertEqual((mapT(steps: 10) { t in a1.interpolate(to: a2, at: t).testDescription }).listJoined, "{{1, 2, 3}, {1.5, 2.1, 2.8}, {2, 2.2, 2.6}, {2.5, 2.3, 2.4}, {3, 2.4, 2.2}, {3.5, 2.5, 2}, {4, 2.6, 1.8}, {4.5, 2.7, 1.6}, {5, 2.8, 1.4}, {5.5, 2.9, 1.2}, {6, 3, 1}}")
    }

    func test2() {
        let f = { [1.0, 2.0, 3.0].interpolate(to: [6.0, 3.0, 1.0], at: $0) }
        XCTAssertEqual((mapT(steps: 10) { f($0).testDescription }).listJoined, "{{1, 2, 3}, {1.5, 2.1, 2.8}, {2, 2.2, 2.6}, {2.5, 2.3, 2.4}, {3, 2.4, 2.2}, {3.5, 2.5, 2}, {4, 2.6, 1.8}, {4.5, 2.7, 1.6}, {5, 2.8, 1.4}, {5.5, 2.9, 1.2}, {6, 3, 1}}")
    }
}
