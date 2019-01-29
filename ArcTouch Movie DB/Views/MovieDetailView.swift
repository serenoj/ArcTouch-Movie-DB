//
//  MovieDetailView.swift
//  ArcTouch Movie DB
//
//  Created by Juan Carlos Correa Arango on 1/28/19.
//  Copyright © 2019 ArcTouch. All rights reserved.
//

import UIKit

class MovieDetailView: UIView {

    @IBOutlet weak private var movieNameLabel: UILabel!
    @IBOutlet weak private var moviePosterImageView: UIImageView!
    @IBOutlet weak private var movieGenresLabel: UILabel!
    @IBOutlet weak private var movieOverviewLabel: UILabel!
    
    func configureView(movie: Movie, genres: String, posterImageView: UIImageView) {
        
        self.movieNameLabel.text = movie.title
        self.moviePosterImageView = posterImageView
        self.movieGenresLabel.text = genres
        self.movieOverviewLabel.text = movie.overview
    }
    
}
