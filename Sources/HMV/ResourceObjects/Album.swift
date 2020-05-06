//
//  Album.swift
//  HMV
//

import Foundation

public typealias Album = Resource<AlbumAttributes, AlbumRelationships>

extension Album {
    
    public func discCount() -> Int? {

        var discCount: Int?

        if let tracks = self.relationships?.tracks.data {
            discCount = tracks.map { $0.attributes!.discNumber }.max()
        }
        return discCount
    }
    
    
    public func tracksForDisc(discNumber: Int) -> [Track]? {
        
        var discTracks: [Track]?
        
        if let albumTracks = self.relationships?.tracks.data {
            discTracks = albumTracks.filter { $0.attributes?.discNumber == discNumber }
        }
        return discTracks
    }
}


public struct AlbumAttributes: Codable, Identifiable {
    public let id = UUID()
    public let artistName: String
    public let artwork: Artwork
    public let contentRating: ContentRating?
    public let copyright: String
    public let editorialNotes: EditorialNotes?
    public let genreNames: [String]
    public let isComplete: Bool
    public let isSingle: Bool
    public let name: String
    public let releaseDate: String
    public let playParams: PlayParameters?
    public let trackCount: Int
    public let url: URL
}

public struct AlbumRelationships: Codable {
    public let artists: Relationship<Artist>
    public let genres: Relationship<Genre>?
    public let tracks: Relationship<Track>
}


