//
//  ShowData.swift
//  BK
//
//  Created by Slava Pashaliuk on 5/1/20.
//  Copyright © 2020 Viachaslau Pashaliuk. All rights reserved.
//

import Foundation

struct ShowData: Decodable {
    let tmdb_id: Int
    let name: String
    let poster_path: String
    let backdrop_path: String
    let overview: String
    let first_air_date: String
    let genre_ids: [Int]
}
