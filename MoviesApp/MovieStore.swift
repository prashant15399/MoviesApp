

import Foundation


public class MovieStore: MovieService{
    
    
    
    static let shared = MovieStore()
    let apiKey = "40fba98ae040578768474f01d823eb7c"
    let baseAPIURL = "https://api.themoviedb.org/3/"
    let urlSession = URLSession.shared
    init() {}
    
    

    //MARK: feching data from server
    func fetchMovies(params: [String: String]? = nil, successHandler successHandler: @escaping (_ response: MoviesResponse) -> Void) {
        
        var baseApiURL = baseAPIURL + "discover/movie?"
        guard var urlComponents = URLComponents(string: baseApiURL) else {
            print("Invalid urlComponents")
            return
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            print("Invalid url")
            return
        }
        //print(url)
        urlSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("unable to get data from server")
                return
            }
            
            guard let data = data else {
                print("no data found")
                return
            }
            
            do {
                let moviesResponse = try JSONDecoder().decode(MoviesResponse.self, from: data)
                DispatchQueue.main.async {
                    successHandler(moviesResponse)
                }
            } catch {
                print(error)
            }
        }.resume()
        
    }
    
    //MARK:fetching searching data
    
    func searchMovie(query: String, params: [String : String]?, successHandler: @escaping (MoviesResponse) -> Void) {
        print(baseAPIURL)
        var baseApiURL = baseAPIURL + "search/movie?"
        guard var urlComponents = URLComponents(string: baseApiURL) else {
            print("Invalid urlComponents")
            return
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey),
                          URLQueryItem(name: "query", value: query)]
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            print("Invalid url")
            return
        }
        print(url)
        urlSession.dataTask(with: url) { (data, response, error) in
                   
                   if error != nil {
                       print("unable to get data from server")
                       return
                   }
                   
                   guard let data = data else {
                       print("no data found")
                       return
                   }
                   
                   do {
                       let moviesResponse = try JSONDecoder().decode(MoviesResponse.self, from: data)
                       DispatchQueue.main.async {
                           successHandler(moviesResponse)
                       }
                   } catch {
                       print(error)
                   }
               }.resume()
    }
}
