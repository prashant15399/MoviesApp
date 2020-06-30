import Foundation


struct MoviesResponse: Codable {
    let page, totalResults, totalPages: Int
    let results: [Movie]
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}
// MARK: - Result
struct Movie: Codable {
    
    let voteCount: Int?
    let posterPath: String?
    let id: Int
    let adult: Bool?
    let originalTitle: String?
    let genreIDS: [Int]?
    let title: String
    let voteAverage: Double?
    let overview, releaseDate: String?
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    enum CodingKeys: String, CodingKey {
        
        case voteCount = "vote_count"
        case posterPath = "poster_path"
        case id, adult
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
}
