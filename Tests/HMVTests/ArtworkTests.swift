//
//  ArtworkTests.swift
//  HMVTests
//

import XCTest
@testable import HMV

class ArtworkTests: XCTestCase {
    func testURL() throws {
        let fetch = try fixture(ResponseRoot<Album>.self, name: "album")

        let album = fetch.data![0]
        XCTAssertEqual(album.attributes?.artwork.url(forWidth: 123), URL(string: "https://example.mzstatic.com/image/thumb/Music3/v4/2d/02/4a/2d024aaa-4547-ca71-7ba1-b8f5e1d98256/source/123x123bb.jpg")!)
    }

    func testURLOverMax() throws {
        let fetch = try fixture(ResponseRoot<Album>.self, name: "album")

        let album = fetch.data![0]
        XCTAssertEqual(album.attributes?.artwork.url(forWidth: 2000), URL(string: "https://example.mzstatic.com/image/thumb/Music3/v4/2d/02/4a/2d024aaa-4547-ca71-7ba1-b8f5e1d98256/source/1500x1500bb.jpg")!)
    }
}

#if os(Linux)
    extension ArtworkTests {
        static var allTests: [(String, (ArtworkTests) -> () throws -> Void)] {
            return [
                ("testURL", testURL),
                ("testURLOverMax", testURLOverMax),
            ]
        }
    }
#endif
