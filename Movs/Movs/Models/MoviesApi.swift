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
    let total_results: Int
    let total_pages: Int
    let results: [Movie]
}

