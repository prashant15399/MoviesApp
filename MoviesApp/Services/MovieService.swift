
import Foundation

protocol MovieService:class {
    
    func fetchMovies(params: [String:String]?, successHandler: @escaping (_ response: MoviesResponse)-> Void)
    func searchMovie(query: String,params: [String:String]?, successHandler: @escaping (_ response: MoviesResponse)-> Void)
}

