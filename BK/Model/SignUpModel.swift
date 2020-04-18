//
//  SignUpModel.swift
//  BK
//
//  Created by Slava Pashaliuk on 4/18/20.
//  Copyright © 2020 Viachaslau Pashaliuk. All rights reserved.
//

import Foundation

struct SignUpModel {
    let externalId: Int
    let title: String
    let poster_path: String
    let backdrop_path: String
    let overview: String
    let release_date: String
    var year: String {
        return String(release_date.split{$0 == "-"}[0])
    }
    let genre_ids: [Int]
}
