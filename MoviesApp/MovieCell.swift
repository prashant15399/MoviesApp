//
//  MovieCell.swift
//  MoviesApp
//
//  Created by Frontend on 6/25/20.
//  Copyright © 2020 Frontend. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var poster: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ movie: Movie) {
            
        poster.kf.setImage(with: movie.posterURL)
        
        
    }
}
