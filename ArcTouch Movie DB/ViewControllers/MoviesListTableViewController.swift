//
//  MoviesListTableViewController.swift
//  ArcTouch Movie DB
//
//  Created by Juan Carlos Correa Arango on 1/25/19.
//  Copyright © 2019 ArcTouch. All rights reserved.
//

import UIKit
import SDWebImage

class MoviesListTableViewController: UITableViewController {

    var sortedMovies: [Movie] = []
    var genres: [Genre] = []
    var pageNumber = 1
    var totalPages = 1
    var totalMovies = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadData()
    }

    private func setupUI() {
        
        self.title = "Upcoming Movies"
    }
    
    private func loadData() {
        
        showActivityIndicator()
        WebService.getGenres { [weak self] (success, result) in

            guard let strongSelf = self else { return }
            
            if success {
                strongSelf.genres = result as! [Genre]
                strongSelf.loadMovies()
            } else {
                strongSelf.dissmissActivityIndicator()
                strongSelf.showErrorAlertForServer(error: result as? Error)
            }
        }
    }
    
    private func loadMovies() {
        
        WebService.getMovies(pageNumber: pageNumber) { [weak self] (success, result, currentPage, totalPages, totalMovies) in
            
            guard let strongSelf = self else { return }
            strongSelf.dissmissActivityIndicator()

            if success {
                strongSelf.pageNumber = currentPage
                strongSelf.totalMovies = totalMovies
                strongSelf.totalPages = totalPages
                
                if currentPage == 1 {
                    strongSelf.sortedMovies.removeAll()
                }
                
                strongSelf.sortedMovies.append(contentsOf: result as! [Movie])

                strongSelf.tableView.reloadData()
            } else {
                strongSelf.showErrorAlertForServer(error: result as? Error)
            }
        }
    }
    
    // Extract from the list of genres in self.genres, the names of those genres in a list of genres Ids
    private func gatherGenresNames(genresIds: [Int]) -> String {
        
        var strArray: [String] = []
        for genreId in genresIds {
            for genre in genres {
                if genre.id == genreId {
                    strArray.append(genre.name)
                }
            }
        }
        
        return strArray.joined(separator: ", ")
    }

    // MARK: - Navigation


    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sortedMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.className, for: indexPath) as? MovieTableViewCell
        
        if let movieCell = cell {
            
            let movie = sortedMovies[indexPath.row]
            let genres: String = gatherGenresNames(genresIds: movie.genre_ids)
            let posterUrlString = Constants.imageBaseUrl + movie.poster_path
            
            movieCell.moviePosterImageView.sd_setImage(with: URL(string: posterUrlString), placeholderImage: UIImage(named: "placeholder.png"))
            movieCell.configureCell(movie: movie, genres: genres)
            
            return movieCell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if indexPath.row == sortedMovies.count - 1 && sortedMovies.count < totalMovies && totalPages > pageNumber {
            pageNumber += 1
            showActivityIndicator()
            loadMovies()
        }
    }
    
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movie = sortedMovies[indexPath.row]
        let genres: String = gatherGenresNames(genresIds: movie.genre_ids)

        if let viewController = MovieDetailViewController.fromStoryboard("Main") {
            
            viewController.genres = genres
            viewController.movie = movie
            
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

