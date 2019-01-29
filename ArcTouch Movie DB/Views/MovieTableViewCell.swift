//
//  MovieTableViewCell.swift
//  ArcTouch Movie DB
//
//  Created by Juan Carlos Correa Arango on 1/25/19.
//  Copyright © 2019 ArcTouch. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieGenresLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!

    func configureCell(movie: Movie, genres: String) {
        
        self.movieNameLabel.text = movie.title
        self.movieGenresLabel.text = genres
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        if let date = dateFormatter.date(from: movie.release_date) {
            self.movieReleaseDateLabel.text = DateFormatter.dateFormatReadableDate.string(from: date)
        } else {
            self.movieReleaseDateLabel.text = movie.release_date
        }
    }

}
