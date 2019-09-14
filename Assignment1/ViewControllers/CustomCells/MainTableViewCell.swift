//
//  MainTableViewCell.swift
//  Assignment1
//
//  Created by Haya Alhumaid on 9/13/19.
//  Copyright © 2019 HayaAlhumaid. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadMovieData(movie: Movie) {
        self.movieNameLabel.text = movie.title
        let link = "https://image.tmdb.org/t/p/w500" + movie.poster_path
        self.posterImageView.downloadFrom(link: link)
    }

}

extension UIImageView {
    func downloadFrom(link:String?) {
        if link != nil, let url = URL(string: link!) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    print("error on download \(error!)")
                    return
                }
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                    print("statusCode != 200; \(httpResponse.statusCode)")
                    return
                }
                DispatchQueue.main.async {
                    print("\ndownload completed \(url.lastPathComponent)")
                    self.image = UIImage(data: data)
                }
                }.resume()
        } else {
            self.image = UIImage(named: "PlaceHolderImage")
        }
    }
}
