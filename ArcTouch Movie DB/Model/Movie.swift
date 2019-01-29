//
//  Movie.swift
//  ArcTouch Movie DB
//
//  Created by Juan Carlos Correa Arango on 1/28/19.
//  Copyright © 2019 ArcTouch. All rights reserved.
//

import Foundation

struct Movie: Codable {

    var poster_path: String
    var overview: String
    var release_date:String
    var genre_ids: [Int]
    var id: Int
    var original_title: String
    var title: String
    var backdrop_path: String
    
    init(poster_path: String,
         overview: String,
         release_date:String,
         genre_ids: [Int],
         id: Int,
         original_title: String,
         title: String,
         backdrop_path: String) {
        
        self.poster_path = poster_path
        self.overview = overview
        self.release_date = release_date
        self.genre_ids = genre_ids
        self.id = id
        self.original_title = original_title
        self.title = title
        self.backdrop_path = backdrop_path
    }
}
