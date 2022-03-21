//
//  SearchViewController.swift
//  Netflix
//
//  Created by Mikail on 17/03/2022.
//

import UIKit

class SearchViewController: UIViewController {

    private var discoverMovies:[Movie] = [Movie]()
    
    private let discoverTableView:UITableView = {
       let tableView = UITableView()
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        return tableView
    }()
    
    private let searchController:UISearchController = {
       let controller = UISearchController(searchResultsController: SearchResultViewController())
        controller.searchBar.placeholder = "Search for a movie or Tv Show"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        navigationItem.searchController = searchController
        
        navigationController?.navigationBar.tintColor = .label
        
        
        view.addSubview(discoverTableView)
        discoverTableView.dataSource = self
        discoverTableView.delegate = self
        
        searchController.searchResultsUpdater = self
        
        getData()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        discoverTableView.frame = view.bounds
    }

    private func getData(){
        APICaller.shared.getDiscoverMovies { result in
            switch result{
            case .success(let movies):
                DispatchQueue.main.async { [weak self] in
                    self?.discoverMovies = movies
                    self?.discoverTableView.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}


extension SearchViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard  let cell = discoverTableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier,for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        let movie = discoverMovies[indexPath.row]
           
       cell.configure(with: MovieViewModel(title: movie.title ?? "", posterURL: movie.poster_path ?? ""))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        discoverMovies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

extension SearchViewController:UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
                !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultsController = searchController.searchResultsController as? SearchResultViewController else{
                  return
              }
        
        APICaller.shared.search(with: query) { result in
            switch result{
            case .success(let model):
                DispatchQueue.main.async {
                    resultsController.searchItems = model
                    resultsController.collectionView.reloadData()
                    print(model)
                }
            
            
            case .failure(let error):
                print(error.localizedDescription)
            }
            

        }
                
    }
}
