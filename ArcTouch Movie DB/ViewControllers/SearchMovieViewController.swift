//
//  SearchMovieViewController.swift
//  ArcTouch Movie DB
//
//  Created by Juan Carlos Correa Arango on 1/28/19.
//  Copyright © 2019 ArcTouch. All rights reserved.
//

import UIKit

class SearchMovieViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var moviesFound: [Movie] = []
    var genres: [Genre] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
    }
    
    private func setupUI() {
        
        self.title = "Search Movies"
    }
    
    private func loadData() {
        
        showActivityIndicator()
        WebService.getGenres { [weak self] (success, result) in
            
            guard let strongSelf = self else { return }
            strongSelf.dissmissActivityIndicator()

            if success {
                strongSelf.genres = result as! [Genre]
            } else {
                strongSelf.showErrorAlertForServer(error: result as? Error)
            }
        }
    }

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
}

extension SearchMovieViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchText.count == 0 {
            
            searchBar.endEditing(true)
            tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        searchBar.endEditing(true)
        
        if let encodedQuery = searchBar.text?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            
            self.showActivityIndicator()
            WebService.searchMovies(query: encodedQuery) { [weak self] (isSuccess, result) in
                
                guard let strongSelf = self else { return }
                strongSelf.dissmissActivityIndicator()
                
                if isSuccess {
                    strongSelf.moviesFound = result as! [Movie]
                    strongSelf.tableView.reloadData()
                } else {
                    strongSelf.showErrorAlertForServer(error: result as? Error)
                }
            }
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        moviesFound = []
        tableView.reloadData()
    }
    
}

extension SearchMovieViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesFound.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.className, for: indexPath) as? MovieTableViewCell
        
        if let movieCell = cell {
            
            let movie = moviesFound[indexPath.row]
            let genres: String = gatherGenresNames(genresIds: movie.genre_ids)
            let posterUrlString = Constants.imageBaseUrl + movie.poster_path
            
            movieCell.moviePosterImageView.sd_setImage(with: URL(string: posterUrlString), placeholderImage: UIImage(named: "placeholder.png"))
            movieCell.configureCell(movie: movie, genres: genres)
            
            return movieCell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movie = moviesFound[indexPath.row]
        let genres: String = gatherGenresNames(genresIds: movie.genre_ids)
        
        if let viewController = MovieDetailViewController.fromStoryboard("Main") {
            
            viewController.genres = genres
            viewController.movie = movie
            
            navigationController?.pushViewController(viewController, animated: true)
        }
    }

}
