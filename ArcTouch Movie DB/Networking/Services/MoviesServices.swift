//
//  MoviesServices.swift
//  ArcTouch Movie DB
//
//  Created by Juan Carlos Correa Arango on 1/28/19.
//  Copyright © 2019 ArcTouch. All rights reserved.
//

import Foundation

// The three services will be defined here:
// - getUpcoming --> gets a list of upcoming movies
// - searchMovie --> gets a list of movies searched by a query string
// - getUpcoming --> gets a the list of movie genres

import Alamofire

class WebService {
    
    static func getMovies(pageNumber: Int, completion: @escaping (Bool, Any?, Int, Int, Int) -> ()) {

        var pageVariable: String = ""
        if pageNumber > 0 {
            pageVariable += "&page=\(pageNumber)"
        }
        
        let url = Constants.baseUrl + MoviesAPI.getUpcoming.path + pageVariable

        Alamofire.request(url).responseJSON { response in
            
            let value: Any? = response.result.isSuccess ? response.result.value : response.result.error

            if response.result.isSuccess, let moviesResult = value as? Dictionary<String, Any> {

                var totalPages: Int = 0
                var totalMovies: Int = 0
                var currentPage: Int = 0
                
                if let currentPageResult = moviesResult["page"] as? Int {
                    currentPage = currentPageResult
                }
                if let totalPagesResult = moviesResult["total_pages"] as? Int {
                    totalPages = totalPagesResult
                }
                if let totalMoviesResult = moviesResult["total_results"] as? Int {
                    totalMovies = totalMoviesResult
                }

                var moviesArray: [Movie] = []
                
                if let dictArray = moviesResult["results"] as? [Dictionary<String, Any>] {
                    
                    for dict in dictArray {

                        let aMovie = Movie(poster_path: dict["poster_path"] as? String ?? "",
                                           overview: dict["overview"] as? String ?? "",
                                           release_date: dict["release_date"] as? String ?? "",
                                           genre_ids: dict["genre_ids"] as? [Int] ?? [],
                                           id: dict["id"] as? Int ?? 0,
                                           original_title: dict["original_title"] as? String ?? "",
                                           title: dict["title"] as? String ?? "",
                                           backdrop_path: dict["backdrop_path"] as? String ?? "")
                        
                        moviesArray.append(aMovie)
                    }
                }
                
                completion(response.result.isSuccess, moviesArray, currentPage, totalPages, totalMovies)
            } else {
                
                let error = value as! Error
                completion(response.result.isSuccess, error, 0, 0, 0)
            }
        }
    }

    static func getGenres(completion: @escaping (Bool, Any?) -> ()) {
        
        let url = Constants.baseUrl + MoviesAPI.getMoviesGenres.path
        
        Alamofire.request(url).responseJSON { response in
            
            let value: Any? = response.result.isSuccess ? response.result.value : response.result.error
            
            if response.result.isSuccess, let genresResult = value as? Dictionary<String, Any> {
                
                var genresArray: [Genre] = []
                
                if let dictArray = genresResult["genres"] as? [Dictionary<String, Any>] {
                    
                    for dict in dictArray {
                        
                        let aGenre = Genre(id: dict["id"] as! Int,
                                           name: dict["name"] as! String)
                        
                        genresArray.append(aGenre)
                    }
                }
                completion(response.result.isSuccess, genresArray)
            } else {
                
                let error = value as! Error
                completion(response.result.isSuccess, error)
            }
        }
    }
    
    static func searchMovies(query: String, completion: @escaping (Bool, Any?) -> ()) {
        
        let url = Constants.baseUrl + MoviesAPI.searchMovies(query: query).path
        
        Alamofire.request(url).responseJSON { response in
            let value: Any? = response.result.isSuccess ? response.result.value : response.result.error
            
            if response.result.isSuccess, let moviesResult = value as? Dictionary<String, Any> {
                
                var moviesArray: [Movie] = []
                
                if let dictArray = moviesResult["results"] as? [Dictionary<String, Any>] {
                    
                    for dict in dictArray {
                        
                        let aMovie = Movie(poster_path: dict["poster_path"] as? String ?? "",
                                           overview: dict["overview"] as? String ?? "",
                                           release_date: dict["release_date"] as? String ?? "",
                                           genre_ids: dict["genre_ids"] as? [Int] ?? [],
                                           id: dict["id"] as? Int ?? 0,
                                           original_title: dict["original_title"] as? String ?? "",
                                           title: dict["title"] as? String ?? "",
                                           backdrop_path: dict["backdrop_path"] as? String ?? "")

                        moviesArray.append(aMovie)
                    }
                }
                completion(response.result.isSuccess, moviesArray)
            } else {
                
                let error = value as! Error
                completion(response.result.isSuccess, error)
            }
        }
    }
}
