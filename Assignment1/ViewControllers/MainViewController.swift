//
//  ViewController.swift
//  Assignment1
//
//  Created by Haya Alhumaid on 9/3/19.
//  Copyright © 2019 HayaAlhumaid. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK:- Interface Builder
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var pageNumberLabel: UILabel!
    @IBOutlet weak var pageStepper: UIStepper!
    @IBOutlet weak var timerSwitch: UISwitch!
    
    //MARK:- Properties
    var movieList = [Movie]()
    var selectedMovie: Movie?
    var pageNumber = 1
    var timer: Timer?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchMovieListFromServer(pageNumber: self.pageNumber)
        self.pageNumberLabel.text = "Page: \(self.pageNumber)"
    }
    
    //MARK:- Methods
    func fetchMovieListFromServer(pageNumber: Int) {
        NetworkServices.fetchMovieList(pageNumber: pageNumber) { (result) in
            switch result {
            case .success(let movieData):
                self.movieList = movieData.results
                self.tableView.reloadData()
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
                print("Errorfetching data from server!")
            }
        }
    }
    
    func configureCollectionView() {
        let flowLayout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.sectionInset.left = 20
        flowLayout.sectionInset.right = 20
    }
    
    @objc func changePageNumber() {
        self.pageNumber = self.pageNumber + 1
        self.pageStepper.value = Double(self.pageNumber)
        self.pageNumberLabel.text = "Page: \(self.pageNumber)"
        self.fetchMovieListFromServer(pageNumber: self.pageNumber)
    }
    
}

//MARK:- TableView Datasource and Delegate Methods
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        cell.loadMovieData(movie: self.movieList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedMovie = self.movieList[indexPath.row]
        self.performSegue(withIdentifier: "ListToDetail", sender: self)
    }
}

//MARK:- CollectionView Delegate and Datasource Methods
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
        cell.loadMovieData(movie: self.movieList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.selectedMovie = self.movieList[indexPath.row]
        self.performSegue(withIdentifier: "ListToDetail", sender: self)
    }
}

//MARK:- Segmentation Actions
extension MainViewController{
    @IBAction func segmentedControllerValueChanged(sender: UISegmentedControl) {
        if self.segmentedController.selectedSegmentIndex == 0 {
            self.tableView.isHidden = false
            self.collectionView.isHidden = true
        } else {
            self.tableView.isHidden = true
            self.collectionView.isHidden = false
        }
    }
}

//MARK:- Stepper Actions
extension MainViewController {
    @IBAction func pageStepperValueChanged(sender: UIStepper) {
        self.pageNumber = Int(self.pageStepper.value)
        self.pageNumberLabel.text = "Page: \(self.pageNumber)"
        self.fetchMovieListFromServer(pageNumber: self.pageNumber)
    }
}

//MARK:- Switch Actions
extension MainViewController {
    @IBAction func timerSwitchValueChanged(sender: UISwitch) {
        if self.timerSwitch.isOn == true {
            self.timer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(changePageNumber), userInfo: nil, repeats: true)
        } else {
            self.timer?.invalidate()
        }
    }
}

//MARK:-Segue
extension MainViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ListToDetail" {
            let detailVC = segue.destination as! DetailViewController
            detailVC.selectedMovie = self.selectedMovie
        }
    }
}

