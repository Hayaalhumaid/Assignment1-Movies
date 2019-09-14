//
//  DetailViewController.swift
//  Assignment1
//
//  Created by Haya Alhumaid on 9/13/19.
//  Copyright © 2019 HayaAlhumaid. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var movieTitle: UILabel!

    @IBOutlet weak var movieImage: UIImageView!
   
    @IBOutlet weak var movieOverview: UILabel!
    
    var selectedMovie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        let link = "https://image.tmdb.org/t/p/w500" + self.selectedMovie!.poster_path

        self.movieTitle.text = self.selectedMovie!.title
        self.movieImage.downloadFrom(link: link)
       self.movieOverview.text = self.selectedMovie!.overview
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
