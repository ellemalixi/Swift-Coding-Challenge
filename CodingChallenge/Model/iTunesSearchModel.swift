//
//  SearchITunes.swift
//  CodingChallenge
//
//  Created by Michelle M on 22/11/2019.
//  Copyright © 2019 iOSPractices. All rights reserved.
//

import Foundation

struct ITunesSearchResult: Decodable {
    var trackName: String?
    var artworkUrl100: String?
    var trackPrice: Double?
    var country: String?
    var currency: String?
    var primaryGenreName: String?
    var longDescription: String?
}

struct ITunesSearch: Decodable {
    var resultCount: Int?
    var results: [ITunesSearchResult?]?
}
