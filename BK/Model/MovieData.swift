//
//  MovieData.swift
//  BK
//
//  Created by Slava Pashaliuk on 4/18/20.
//  Copyright © 2020 Viachaslau Pashaliuk. All rights reserved.
//

import Foundation

struct MovieData: Decodable {
    let tmdb_id: Int
    let title: String
    let poster_path: String
    let backdrop_path: String
    let overview: String
    let release_date: String
    let genre_ids: [Int]
}
