//
//  SearchITunes.swift
//  CodingChallenge
//
//  Created by Michelle M on 22/11/2019.
//  Copyright © 2019 iOSPractices. All rights reserved.
//

import Foundation

struct SearchITunes: Decodable {
    var trackName: String?
    var artworkUrl60: String?
    var trackPrice: String?
    var primaryGenreName: String?
    var longDescription: String?
    
    enum SerializationError: Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    //MARK: - API Call
    
    init(json:[String: Any]) throws {
        guard let trackName = json["trackName"] as? String else {
            throw SerializationError.missing("Track name is missing")
        }
        guard let artworkUrl60 = json["artworkUrl60"] as? String else {
            throw SerializationError.missing("Artwork is missing")
        }
        guard let trackPrice = json["trackPrice"] as? String else {
            throw SerializationError.missing("Track price is missing")
        }
        guard let primaryGenreName = json["primaryGenreName"] as? String else {
            throw SerializationError.missing("Genre name is missing")
        }
        guard let longDescription = json["longDescription"] as? String else {
            throw SerializationError.missing("Long description is missing")
        }
        
        self.trackName = trackName
        self.artworkUrl60 = artworkUrl60
        self.trackPrice = trackPrice
        self.primaryGenreName = primaryGenreName
        self.longDescription = longDescription
    }
    static let basePath = "https://itunes.apple.com/search?term=star&amp;country=au&amp;media=movie&amp;all"
    
    
    
}

struct SearchITunesFormatted {
    var trackName: String
    var artworkUrl60: String
    var trackPrice: String
    var primaryGenreName: String
    var longDescription: String
}
