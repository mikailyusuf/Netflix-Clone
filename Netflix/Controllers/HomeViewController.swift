//
//  HomeViewController.swift
//  Netflix
//
//  Created by Mikail on 17/03/2022.
//

import UIKit


enum Section:Int{
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}


class HomeViewController: UIViewController {
    
    let sectionTitles:[String] = ["Trending Movies","Trending Tv","Popular", "Upcoming movies","Top rated"]
    
    let homeFeedTable:UITableView = {
        let tableView = UITableView(frame: .zero,style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        configureNavBar()
        getData()
        
        let headerImgeView = HeroHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = headerImgeView
    }
    
    
    private func getData(){

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }

    private func configureNavBar(){
        
        var image = UIImage(named: "logo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil),
        ]
        
        navigationController?.navigationBar.tintColor = .label
    }

}

extension HomeViewController:UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = homeFeedTable.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        
        switch indexPath.section{
        case Section.TrendingMovies.rawValue:
            APICaller.shared.getTrendingMovies { results in

                switch results {
                case .success(let movies):
                    cell.configure(with: movies)

                case .failure(let error):
                    print(error.localizedDescription)
                }

            }
            
        case Section.Popular.rawValue :
            APICaller.shared.getPopularMovies { results in
                
                switch results {
                case .success(let movies):
                    cell.configure(with: movies)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
            }
        
        case Section.TrendingTv.rawValue :
            
            APICaller.shared.getTrendingTv { results in

                switch results {
                case .success(let movies):
                    cell.configure(with: movies)

                case .failure(let error):
                    print(error.localizedDescription)
                }

        }
            
        case Section.Upcoming.rawValue:
            APICaller.shared.getUpcomingMovies { results in

                switch results {
                case .success(let movies):
                    cell.configure(with: movies)

                case .failure(let error):
                    print(error.localizedDescription)
                }

            }
            
        case Section.TopRated.rawValue:
            APICaller.shared.getTopRatedMovies { results in
                
                switch results {
                case .success(let movies):
                    cell.configure(with: movies)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
            }
            
        default:
            return UITableViewCell()
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        homeFeedTable.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: 20, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .label
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffSet = view.safeAreaInsets.top
        let offSet = scrollView.contentOffset.y + defaultOffSet
        
        navigationController?.navigationBar.transform = .init(translationX:0, y:min(0, -offSet))
    }
}
