//
//  Movie.swift
//  Movs
//
//  Created by gustavo.cosenza on 04/06/19.
//  Copyright © 2019 Gustavo. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    let vote_count: Int
    let id: Int
    let video: Bool
    let vote_average: Float
    let title: String
    let popularity: Float
    let poster_path: String
    let original_language: String
    let original_title: String
    let genre_ids: [Int]
    let backdrop_path: String?
    let adult: Bool
    let overview: String
    let release_date: String
}
