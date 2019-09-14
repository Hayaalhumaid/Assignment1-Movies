//
//  Movie.swift
//  Assignment1
//
//  Created by Haya Alhumaid on 9/13/19.
//  Copyright © 2019 HayaAlhumaid. All rights reserved.
//

import Foundation

struct MovieData: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    var popularity: Double
    var vote_count: Int
    var video: Bool
    var poster_path: String
    var id : Int
    var adult: Bool
    var backdrop_path: String
    var original_language: String
    var original_title: String
    var genre_ids: [Int]
    var title: String
    var vote_average: Double
    var overview: String
    var release_date: String
}
