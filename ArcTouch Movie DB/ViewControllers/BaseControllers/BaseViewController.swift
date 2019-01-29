//
//  BaseViewController.swift
//  ArcTouch Movie DB
//
//  Created by Juan Carlos Correa Arango on 1/28/19.
//  Copyright © 2019 ArcTouch. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var genres: [Genre] = []

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // Extract from the list of genres in self.genres, the names of those genres in a list of genres Ids
    func gatherGenresNames(genresIds: [Int]) -> String {
        
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
