//
//  DetailViewController.swift
//  Assignment1
//
//  Created by Haya Alhumaid on 9/13/19.
//  Copyright © 2019 HayaAlhumaid. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
   
//MARK:- Interface Builder
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var changeImageView: UIPickerView!
    @IBOutlet weak var likedButton: UIButton!
    @IBOutlet weak var unlikeButton: UIView!
    @IBOutlet weak var likeLabel: UILabel!
    
    //MARK:- Properties
    var likedMovie = ""
    var selectedMovie: Movie?
    private let dataSource = ["Poster Image", "Backdrop Image"]


    override func viewDidLoad() {
        super.viewDidLoad()
        let link = "https://image.tmdb.org/t/p/w500" + self.selectedMovie!.poster_path
        let link2 = "https://image.tmdb.org/t/p/w500" + self.selectedMovie!.backdrop_path

        self.movieTitle.text = self.selectedMovie!.title
        self.movieImage.downloadFrom(link: link)
        self.movieOverview.text = self.selectedMovie!.overview
        
        
//        pickerView.dataSource = self
//        pickerView.delegate = self
    }

}

////MARK:- Picker Actions
//extension DetailViewController : UIPickerViewDelegate , UIPickerViewDataSource{
//    
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return dataSource.count
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        detailLabel.text = dataSource[row]
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return dataSource[row]
//    }
//    
//}
