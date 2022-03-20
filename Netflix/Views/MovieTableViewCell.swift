//
//  MovieTableViewCell.swift
//  Netflix
//
//  Created by Mikail on 20/03/2022.
//

import UIKit
import SDWebImage

class MovieTableViewCell: UITableViewCell {
    static let identifier = "MovieTableViewCell"
    
    let playButton : UIButton = {
       let button = UIButton()
        let image = UIImage(
            systemName: "play.circle",withConfiguration: UIImage.SymbolConfiguration(pointSize: 40))
        button.setImage(image, for: .normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let titleLabel:UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let posterImageView:UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 2
        return imageView
    }()
    

    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(posterImageView)
        contentView.addSubview(playButton)
        contentView.addSubview(titleLabel)
      
        
        applyConstrainst()
    }
    

    
    private func applyConstrainst(){
        let posterImageViewConstraints = [
        
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10),
            posterImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let titleConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        let playButtonConstrains = [
            playButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
    
        NSLayoutConstraint.activate(posterImageViewConstraints)
        NSLayoutConstraint.activate(titleConstraints)
        NSLayoutConstraint.activate(playButtonConstrains)
    }
    
    public func configure(with model:MovieViewModel){
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {return}
        
        posterImageView.sd_setImage(with: url, completed: nil)
        titleLabel.text = model.title
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}
