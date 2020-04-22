import XCTest
@testable import HMVTests

XCTMain([
    testCase(AlbumTests.allTests),
    testCase(ArtistTests.allTests),
    testCase(ArtworkTests.allTests),
    testCase(HMVUrlBuilderTests.allTests),
    testCase(HMVTests.allTests),
    testCase(TrackTests.allTests),
    testCase(PlaylistTests.allTests),
    testCase(MusicVideoTests.allTests),
])
