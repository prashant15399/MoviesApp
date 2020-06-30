

import UIKit

class CollectionViewController: UICollectionViewController, UITextFieldDelegate {
    
    //MARK:Properties
    
    //NavigationBar Properties
    let searchController = UISearchController(searchResultsController: nil)
    var isSearchBarEmpty:Bool {
        
        return searchController.searchBar.text?.isEmpty ?? true
    }
    var isSearching: Bool {
        
        return searchController.isActive && !isSearchBarEmpty
    }
    
    //Mark: Data Properties
    var movieService: MovieService = MovieStore.shared
    var totalResults = 0
    var currentPage = 1
    var isFetchInProgress = false
    var newMovies = [Movie]()
    var movies = [Movie]() {
        didSet {
            
            if currentPage == 1 {
                print(currentPage)
                collectionView.reloadData()
            }else if currentPage > 1 && !isSearching {
                print(currentPage)
                collectionView.reloadItems(at: calculateIndexPathsToReload(from: newMovies))
            }
        }
    }
    var searchMovies = [Movie]() {
        
        didSet {
            
            collectionView.reloadData()
        }
    }

    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.fetchMovies()
        collectionView.prefetchDataSource = self
        self.configureSearchBar()
        
    }
    
    //MARK: Actions
    
    private func fetchMovies() {
        
       guard !isFetchInProgress else {
         return
       }
        
       isFetchInProgress = true
        
        movieService.fetchMovies(params: ["page":" \(currentPage)"], successHandler: { [unowned self] (response) in
            self.isFetchInProgress = false
            self.newMovies = response.results
            self.movies.append(contentsOf: response.results)
            self.totalResults = response.totalResults
            self.currentPage += 1
        }) 
    }
    
    //Configure SearchController
    
    private func configureSearchBar() {
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        navigationItem.searchController = searchController
        
       //navigationItem.hidesSearchBarWhenScrolling = false
        searchController.definesPresentationContext = false
        
    }
    
    
    //MARK: DataSource Method
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if !isSearchBarEmpty {
            
            return searchMovies.count
        }
        return totalResults
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        //Desplay Search Result
        if !isSearchBarEmpty {
            
            let movie = searchMovies[indexPath.item]
            cell.configure(movie)
            return cell
        }
        
        //Desplay Main Screen Data
        if movies.count > indexPath.item {
            
            let movie = movies[indexPath.item]
            cell.configure(movie)
        }
        
        return cell
    }
    override func collectionView(_: UICollectionView, didSelectItemAt: IndexPath){
        
        if let vc = storyboard?.instantiateViewController(identifier:"MovieDetailViewController") as? MovieDetailViewController {
            
            if isSearching {
                vc.movie = searchMovies[didSelectItemAt.item]
            }
            else {
                vc.movie = movies[didSelectItemAt.item]
            }
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        print("data")
        
    }
}

//MARK: CollectioView Delegate Method
//extension CollectionViewController: UICollectionViewDe


//MARK: Prefetching of data and loading data
extension CollectionViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]){
        print("prefetch")
        if indexPaths.contains(where: isLoadingCell){
           
            self.fetchMovies()
           
        }
    }
}

extension CollectionViewController {
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= movies.count
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = self.collectionView.indexPathsForVisibleItems
      let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
      return Array(indexPathsIntersection)
    }
    
    private func calculateIndexPathsToReload(from newMovies: [Movie]) -> [IndexPath] {
      let startIndex = movies.count - newMovies.count
      let endIndex = startIndex + newMovies.count
      return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }

    
}

//MARK: Searching Data and update view
extension CollectionViewController: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if isSearching {
            movieService.searchMovie(query: searchController.searchBar.text!, params: nil, successHandler: { [unowned self] (response) in
                
                self.searchMovies = response.results
                
            })
        }
        if !isSearching{
            collectionView.reloadData()
        }
    }
}
//MARK: Configuring Cell
extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        return CGSize(width: (collectionView.frame.size.width-20)/3, height: 200)
    }
    
    
    
}
