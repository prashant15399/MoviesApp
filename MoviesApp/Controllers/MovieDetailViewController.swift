////
////  CompanyDetailViewController.swift
////  MoviesApp
////
////  Created by Frontend on 6/25/20.
////  Copyright © 2020 Frontend. All rights reserved.
////
//
//import UIKit
//
//class MovieDetailViewController: UIViewController {
//    
//    //MARK:Properties
//    @IBOutlet weak var poster: UIImageView!
//    @IBOutlet weak var movieTitle: UILabel!
//    @IBOutlet weak var releaseDate: UILabel!
//    @IBOutlet weak var originalLanguage: UILabel!
//    @IBOutlet weak var rating: UILabel!
//    @IBOutlet weak var totalVote: UILabel!
//    var movieService = MovieService()
//    var movieDetails = [Movie]()
//    var collectionViewControlller = CollectionViewController()
//    var moviePoster: [NSData]?
//    var movieIndex:Int?
//    
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        //collectionViewControlller.delegate = self
//       
//        //movieDetails = movieService.movieDetail()
//         //movieService.delegate = self
//        
//
//       
//    }
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
//
//extension MovieDetailViewController: CollectionViewControllerDelegate,MovieServiceDelegate{
//    func ismoviePosterDownloaded(moviePoster: [NSData]) {
//        
//    }
//    
//    func ismovieDetailAvailable(movieDetail: [Movie]) {
//        movieDetails = movieDetail
//        
//        self.viewDidLoad()
//    }
//    
//    func cellInformation(indexPath: Int, moviePoster: [NSData]) {
//        self.movieIndex = indexPath
//        self.moviePoster = moviePoster
//        poster.image = UIImage(data: moviePoster[indexPath] as Data)
//        movieTitle.text = movieDetails[indexPath].title
//        rating.text = "\(movieDetails[indexPath].voteAverage)"
//        originalLanguage.text = "\(movieDetails[indexPath].originalLanguage) "
//        totalVote.text = "\(movieDetails[indexPath].voteCount)"
//        releaseDate.text = movieDetails[indexPath].releaseDate
//        
//        
//        
//    }
//    
//    
//}
