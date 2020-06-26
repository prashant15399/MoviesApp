//
//  MovieService.swift
//  MoviesApp
//
//  Created by Frontend on 6/24/20.
//  Copyright © 2020 Frontend. All rights reserved.
//

import Foundation
protocol  MovieServiceDelegate: class {
    func ismoviePosterDownloaded(moviePoster: [NSData])
    func ismovieDetailAvailable(movieDetail:[Movie])
}

class MovieService {
    //MARK: Properties
     var moviePoster = [NSData]()
    weak var delegate: MovieServiceDelegate?
    
    
    //MARK: Actions
     func fatchMovies(urlToExcute:URL, handler: @escaping (MoviesResponse?,Error?) -> Void){
        
        print("fatch")
        let urlSession = URLSession.shared
        let urlRequest = URLRequest(url: urlToExcute)
        
        
        let data = urlSession.dataTask(with: urlRequest) { [weak self] (data,response,error) -> Void in
            
            if error != nil{
                print("simple error")
                handler(nil,error)
                return
            }
            
            guard let data = data else {
                print("data error")
                handler(nil,error)
                return
                
            }
            
            do {
                print("data")
                let movies = try JSONDecoder().decode(MoviesResponse.self,from: data)
                
                handler(movies,nil)
                
            }catch{
                print(error)
            
                handler(nil,error)
            }
            
        }
        
        data.resume()
    }
    
      func getMoviePoster()-> [NSData] {
         
          
          let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=40fba98ae040578768474f01d823eb7c&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1")
          self.fatchMovies(urlToExcute: url!){ (movieResponse,error) in
            DispatchQueue.main.async {
                  
                  guard let movieResponse = movieResponse else{
                          
                          return
                      }
                      
                      for case let movie in  movieResponse.results{
                        
                        let posterLink = "http://image.tmdb.org/t/p/w185/\(movie.posterPath)"
                        
                        let url = URL(string: posterLink)
                        let data = NSData(contentsOf: url!)
                        if data != nil{
                            self.moviePoster.append(data!)
                            self.delegate?.ismoviePosterDownloaded(moviePoster: self.moviePoster)
                            
                            print(self.moviePoster.count
                            )
                            
                        }
                        else{
                            print("data not found" )
                        }
                        
                          
                          
                      }
                      
                  }
            
              }
                 
        return self.moviePoster
         }
    func movieDetail()-> [Movie]{
        var movieDetails = [Movie]()
        let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=40fba98ae040578768474f01d823eb7c&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1")
        self.fatchMovies(urlToExcute: url!){ (movieResponse,error) in
          DispatchQueue.main.async {
                
            guard let movieResponse = movieResponse else{
                        
                        return
            }
            
            guard let movies = movieResponse.results as? [Movie] else{
                print(error)
                
            }
            
            movieDetails = movieResponse.results
            self.delegate?.ismovieDetailAvailable(movieDetail: movieDetails)
            
            
                    
                    
                        
                        
                    
                    
        }
          
        }
        return movieDetails
        
   }
    
    
}

