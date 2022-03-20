//
//  TitleCollectionViewCell.swift
//  Netflix
//
//  Created by Mikail on 20/03/2022.
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TitleCollectionViewCell"
    
    let posterImageView:UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 2
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    
    
    override func layoutSubviews() {
        posterImageView.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    public func configure(with model:String){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else {return}
        
        posterImageView.sd_setImage(with: url, completed: nil)
        
    }
    
}
