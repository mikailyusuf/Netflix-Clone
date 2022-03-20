//
//  CollectionViewTableViewCell.swift
//  Netflix
//
//  Created by Mikail on 17/03/2022.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell {

static let identifier = "CollectionViewTableViewCell"
    
    private var movies:[Movie] = [Movie]()
    
    private let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.itemSize  = CGSize(width:140,height:200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBlue
        contentView.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    public func configure(with movies:[Movie]){
        self.movies = movies
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else{
            return UICollectionViewCell()
        }
        
         let posterPath = movies[indexPath.row].poster_path ?? ""
        cell.configure(with: posterPath )
        
        cell.backgroundColor = .systemMint
        return cell
    }
    

}

