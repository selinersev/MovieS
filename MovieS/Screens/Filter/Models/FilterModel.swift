//
//  FilterModel.swift
//  MovieS
//
//  Created by Selin Ersev on 30.01.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import Foundation

struct genreList: Codable {
    let genres: [MovieGenre]
}

struct MovieGenre: Codable {
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
