//
//  MoviesAPI.swift
//  ArcTouch Movie DB
//
//  Created by Juan Carlos Correa Arango on 1/24/19.
//  Copyright © 2019 ArcTouch. All rights reserved.
//

import Foundation

/// Defines the public API for the `MOVIES` services.
/// Will be included here the definition for the three services to consume

// Being a simple service, we won't need complex definitions for:
// HeaderType: .Token Auth Header Type, .None Header Type or .Basic AuthHeader Type
// RequestType: .get, .post, .put, .delete   -->  always GET
/* Example:
enum HttpMethod<Body> {
    case get
    case post(Body)
}

extension HttpMethod {
    var method: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        }
    }
}
*/

// We won't need a builder object for the url   -->  always development
/*
public enum BuildEnviornment: Int {
    case development = 0, stage, production
    
    var staticContentBaseURL : String {
        switch self {
        case .development:
            return "https://api.themoviedb.org/3"
 
        case .stage:
            return ""
 
        case .production:
            return ""
        }
    }
}
*/


// Only the path will be defined
enum MoviesAPI {
    case getUpcoming
    case getMoviesGenres
    case searchMovies(query: String)

    var path: String {
        switch self {
        case .getUpcoming:
            return Constants.upcomingPath + "?api_key=\(Constants.apiKeyValue)"
        case .getMoviesGenres:
            return Constants.genresPath + "?api_key=\(Constants.apiKeyValue)"
        case .searchMovies(let query):
            return Constants.searchPath + "?api_key=\(Constants.apiKeyValue)&query=\(query)"
        }
    }
}

