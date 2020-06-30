//
//  CompanyDetailViewController.swift
//  MoviesApp
//
//  Created by Frontend on 6/25/20.
//  Copyright © 2020 Frontend. All rights reserved.
//

import UIKit
import Kingfisher
class MovieDetailViewController: UIViewController {
    
    //MARK:Properties
    @IBOutlet var poster: UIImageView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var overView: UILabel!
    var movie: Movie?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        poster.kf.setImage(with: movie?.posterURL)
        movieTitle.text =  movie?.title
        overView.text = movie?.overview

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // G!et the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

