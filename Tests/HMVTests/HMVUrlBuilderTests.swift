//
//  HMVUrlBuilderTests.swift
//  HMVTests
//

import XCTest
@testable import HMV

class HMVUrlBuilderTests: XCTestCase {

    let limit = 10
    let offset = 30
    let devToken = "devToken"
    let storefront = Storefront.unitedStates

    var builder: HMVUrlBuilder {
        return HMVUrlBuilder(storefront: storefront, developerToken: devToken)
    }

    // MARK: Search

    let term = "search term"
    let types = [MediaType.albums, MediaType.songs]

    var searchRequest: URLRequest {
        return builder.searchRequest(term: term, limit: limit, offset: offset, types: types)
    }

    func testSearchRequestUrl() {
        XCTAssertEqual(searchRequest.url?.absoluteString, "https://api.music.apple.com/v1/catalog/us/search?term=search+term&limit=10&offset=30&types=albums,songs")
    }

    func testSearchRequestHeaders() {
        XCTAssertEqual(searchRequest.allHTTPHeaderFields!, ["Authorization": "Bearer devToken"])
    }

    func testSearchRequestMethod() {
        XCTAssertEqual(searchRequest.httpMethod, "GET")
    }

    func testSearchWithDefaults() {
        let request = builder.searchRequest(term: term, limit: nil, offset: nil, types: nil)
        XCTAssertEqual(request.url?.absoluteString, "https://api.music.apple.com/v1/catalog/us/search?term=search+term")
    }

    func testSearchHintsWithDefaults() {
        let request = builder.searchHintsRequest(term: term, limit: nil, types: nil)
        XCTAssertEqual(request.url?.absoluteString, "https://api.music.apple.com/v1/catalog/us/search/hints?term=search+term")
    }

    // MARK: Fetch

    func testFetchArtistRequest() {
        let request = builder.fetchRequest(mediaType: .artists, id: "id123", include: nil)
        XCTAssertEqual(request.url, URL(string: "https://api.music.apple.com/v1/catalog/us/artists/id123")!)
        XCTAssertEqual(request.allHTTPHeaderFields!, ["Authorization": "Bearer devToken"])
    }

    func testFetchAlbumRequest() {
        let request = builder.fetchRequest(mediaType: .albums, id: "id123", include: nil)
        XCTAssertEqual(request.url, URL(string: "https://api.music.apple.com/v1/catalog/us/albums/id123")!)
        XCTAssertEqual(request.allHTTPHeaderFields!, ["Authorization": "Bearer devToken"])
    }

    func testFetchSongRequest() {
        let request = builder.fetchRequest(mediaType: .songs, id: "id123", include: nil)
        XCTAssertEqual(request.url, URL(string: "https://api.music.apple.com/v1/catalog/us/songs/id123")!)
        XCTAssertEqual(request.allHTTPHeaderFields!, ["Authorization": "Bearer devToken"])
    }

    func testFetchPlaylistRequest() {
        let request = builder.fetchRequest(mediaType: .playlists, id: "id123", include: nil)
        XCTAssertEqual(request.url, URL(string: "https://api.music.apple.com/v1/catalog/us/playlists/id123")!)
        XCTAssertEqual(request.allHTTPHeaderFields!, ["Authorization": "Bearer devToken"])
    }

    func testFetchMusicVideosRequest() {
        let request = builder.fetchRequest(mediaType: .musicVideos, id: "id123", include: nil)
        XCTAssertEqual(request.url, URL(string: "https://api.music.apple.com/v1/catalog/us/music-videos/id123")!)
        XCTAssertEqual(request.allHTTPHeaderFields!, ["Authorization": "Bearer devToken"])
    }

    func testFetchAlbumRequestWithInclude() {
        let request = builder.fetchRequest(mediaType: .albums, id: "id123", include: [.artists, .tracks])
        XCTAssertEqual(request.url, URL(string: "https://api.music.apple.com/v1/catalog/us/albums/id123?include=artists,tracks")!)
        XCTAssertEqual(request.allHTTPHeaderFields!, ["Authorization": "Bearer devToken"])
    }

    // MARK: Relationships

    func testRelationshipRequestWithLimitAndOffset() {
        let path = "/v1/catalog/us/artists/id123/albums"
        let request = builder.relationshipRequest(path: path, limit: 25, offset: 50)
        XCTAssertEqual(request.url, URL(string: "https://api.music.apple.com/v1/catalog/us/artists/id123/albums?limit=25&offset=50")!)
        XCTAssertEqual(request.allHTTPHeaderFields!, ["Authorization": "Bearer devToken"])
    }

    // MARK: User Token

    func testAddUserToken() {
        var myBuilder = builder
        myBuilder.userToken = "user_token"
        var request = URLRequest(url: URL(string: "http://example.com")!)
        request = try! myBuilder.addUserToken(request: request)
        XCTAssertEqual(request.allHTTPHeaderFields!, ["Music-User-Token": "user_token"])
    }

    func testAddUserTokenThrowsWithNoToken() {
        var request = URLRequest(url: URL(string: "http://example.com")!)
        expect(error: HMVUrlBuilderError.noUserToken) {
            request = try builder.addUserToken(request: request)
        }
    }
}

#if os(Linux)
    extension HMVUrlBuilderTests {
        static var allTests: [(String, (HMVUrlBuilderTests) -> () throws -> Void)] {
            return [
                ("testSearchRequestUrl", testSearchRequestUrl),
                ("testSearchRequestHeaders", testSearchRequestHeaders),
                ("testSearchRequestMethod", testSearchRequestMethod),
                ("testSearchWithDefaults", testSearchWithDefaults),
                ("testSearchHintsWithDefaults", testSearchHintsWithDefaults),
                ("testFetchArtistRequest", testFetchArtistRequest),
                ("testFetchAlbumRequest", testFetchAlbumRequest),
                ("testFetchSongRequest", testFetchSongRequest),
                ("testFetchPlaylistRequest", testFetchPlaylistRequest),
                ("testFetchMusicVideosRequest", testFetchMusicVideosRequest),
                ("testFetchAlbumRequestWithInclude", testFetchAlbumRequestWithInclude),
                ("testRelationshipRequestWithLimitAndOffset", testRelationshipRequestWithLimitAndOffset),
                ("testAddUserToken", testAddUserToken),
                ("testAddUserTokenThrowsWithNoToken", testAddUserTokenThrowsWithNoToken)
            ]
        }
    }
#endif
