//
//  MovieDetailViewController.swift
//  ArcTouch Movie DB
//
//  Created by Juan Carlos Correa Arango on 1/25/19.
//  Copyright © 2019 ArcTouch. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak private var movieNameLabel: UILabel!
    @IBOutlet weak private var moviePosterImageView: UIImageView!
    @IBOutlet weak private var movieGenresLabel: UILabel!
    @IBOutlet weak private var movieOverviewLabel: UILabel!
    
    var movie: Movie = Movie(poster_path: "", overview: "", release_date: "", genre_ids: [], id: 0, original_title: "", title: "", backdrop_path: "")
    var genres: String = ""
    var posterImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        
        self.movieNameLabel.text = movie.title
        let posterUrlString = Constants.imageBaseUrl + movie.poster_path
        self.moviePosterImageView.sd_setImage(with: URL(string: posterUrlString), placeholderImage: UIImage(named: "placeholder.png"))

        self.movieGenresLabel.text = genres
        self.movieOverviewLabel.text = movie.overview
    }
    
}
