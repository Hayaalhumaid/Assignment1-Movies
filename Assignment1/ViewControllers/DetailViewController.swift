//
//  DetailViewController.swift
//  Assignment1
//
//  Created by Haya Alhumaid on 9/13/19.
//  Copyright © 2019 HayaAlhumaid. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIScrollViewDelegate {
    
   
//MARK:- Interface Builder
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var changeImageView: UIPickerView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var scroll: UIScrollView!
    
    
    //MARK:- Properties
    var selectedMovie: Movie?
    private let label = ["Poster Image", "Backdrop Image"]
    private var imageUrls: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.scroll.minimumZoomScale = 1.0
        self.scroll.maximumZoomScale = 6.0
        
        let link = "https://image.tmdb.org/t/p/w500" + self.selectedMovie!.poster_path
        let link2 = "https://image.tmdb.org/t/p/w500" + self.selectedMovie!.backdrop_path
        imageUrls = [link,link2]

        self.movieTitle.text = self.selectedMovie!.title
        self.movieImage.downloadFrom(link: link)
        self.movieOverview.text = self.selectedMovie!.overview
    
        
        changeImageView.dataSource = self
        changeImageView.delegate = self
        
        slider.isHidden = true
   }

//MARK:- Slider Actions
    @IBAction func showSlider(_ sender: Any) {
        slider.isHidden = false
        
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
     movieTitle.font = movieTitle.font.withSize(CGFloat(Int(sender.value)))
    }

//MARK:- Zooming Actions

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.movieImage

    }

//MARK:- Landscape Actions
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        print(newCollection.horizontalSizeClass == .compact ? "portrait" : "landscape")
    }
    
}



//MARK:- Picker Actions
extension DetailViewController : UIPickerViewDelegate , UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return label.count
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.movieImage.downloadFrom(link: imageUrls[row])
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return label[row]
    }

}


