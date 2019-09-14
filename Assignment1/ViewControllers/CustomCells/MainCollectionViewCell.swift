//
//  MainViewControllerCollectionViewCell.swift
//  Assignment1
//
//  Created by Haya Alhumaid on 9/14/19.
//  Copyright © 2019 HayaAlhumaid. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    //MARK:- Interface Builder
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    
    func loadMovieData(movie: Movie) {
        self.movieNameLabel.text = movie.title
        let link = "https://image.tmdb.org/t/p/w500" + movie.poster_path
        self.moviePosterImageView.downloadFrom(link: link)
    }
    
}
