//
//  MoviesApi.swift
//  Movs
//
//  Created by gustavo.cosenza on 04/06/19.
//  Copyright © 2019 Gustavo. All rights reserved.
//

import Foundation

struct MoviesApi: Decodable {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}
//
//let page, totalResults, totalPages: Int
//let results: [Result]
//
//
