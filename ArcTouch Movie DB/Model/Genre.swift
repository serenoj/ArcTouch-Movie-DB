//
//  Genre.swift
//  ArcTouch Movie DB
//
//  Created by Juan Carlos Correa Arango on 1/24/19.
//  Copyright © 2019 ArcTouch. All rights reserved.
//

import Foundation

struct Genre: Codable {
    var id: Int
    var name: String
    
    init(id: Int,
         name: String) {
        
        self.id = id
        self.name = name
    }
}
