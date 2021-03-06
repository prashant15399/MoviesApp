//
//  CollectionViewController.swift
//  MoviesApp
//
//  Created by Frontend on 6/24/20.
//  Copyright © 2020 Frontend. All rights reserved.
//

import UIKit
protocol CollectionViewControllerDelegate: class{
    func cellInformation(indexPath:Int ,moviePoster:[NSData])
}

class CollectionViewController: UICollectionViewController, UITextFieldDelegate {
    
    
    //MARK: Properties
    private let reuseIdentifier = "MovieCell"
    var moviePoster = [NSData]()
    var movieServices = MovieService()
    weak var delegate: CollectionViewControllerDelegate?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieServices.delegate = self
        moviePoster = movieServices.getMoviePoster()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

       
    }
    
    //MARK: Actions
    
    func updateDataOfCell(_ cell:UICollectionViewCell,_ indexPath:IndexPath ){
        let imageView:UIImageView=UIImageView(frame: CGRect(x: 0, y: 0, width: 115, height: 160))
        imageView.image = UIImage(data: moviePoster[indexPath.row] as Data)
        cell.backgroundColor = .green
        cell.contentView.addSubview(imageView)
        
    }

    @IBAction func getMovieDetail(_ sender: UITapGestureRecognizer){
        print("addcontroller")
        
        
        
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return moviePoster.count
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
     
        updateDataOfCell(cell,indexPath)
        
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(identifier: "MovieDetailViewController"){
            self.navigationController?.pushViewController(vc, animated: true)
            self.delegate?.cellInformation(indexPath: indexPath.row, moviePoster: moviePoster)
            
        }
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension CollectionViewController: MovieServiceDelegate{
    func ismovieDetailAvailable(movieDetail: [Movie]) {
        
    }
    
    
    func ismoviePosterDownloaded(moviePoster:[NSData]) {
        self.collectionView!.reloadData()
        self.moviePoster = moviePoster
        
    }
    
    
}
