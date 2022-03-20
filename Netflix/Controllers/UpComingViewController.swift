//
//  UpComingViewController.swift
//  Netflix
//
//  Created by Mikail on 17/03/2022.
//

import UIKit

class UpComingViewController: UIViewController {

    private var upComingMovies:[Movie] = [Movie]()
    
    private let upComingTableView:UITableView = {
       let tableView = UITableView()
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(upComingTableView)
       
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        
        upComingTableView.delegate = self
        upComingTableView.dataSource = self
        
        getUpComingMovies()
    }
    
    override func viewDidLayoutSubviews() {
        upComingTableView.frame = view.bounds
    }
    
    private func getUpComingMovies(){
        
        APICaller.shared.getUpcomingMovies { results in

            switch results {
            case .success(let movies):
                DispatchQueue.main.async { [weak self] in
                    self?.upComingMovies = movies
                    self?.upComingTableView.reloadData()
                }
                

            case .failure(let error):
                print(error.localizedDescription)
            }

        }
    }

}

extension UpComingViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = upComingTableView.dequeueReusableCell(
            withIdentifier: MovieTableViewCell.identifier,for: indexPath) as? MovieTableViewCell else{
                return UITableViewCell()
            }
        
         let movie = upComingMovies[indexPath.row]
            
        cell.configure(with: MovieViewModel(title: movie.title ?? "", posterURL: movie.poster_path ?? ""))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  upComingMovies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
