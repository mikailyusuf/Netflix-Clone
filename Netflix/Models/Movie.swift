//
//  Movie.swift
//  Netflix
//
//  Created by Mikail on 17/03/2022.
//

import Foundation
struct TrendingMoviesResponse:Codable{
    
    let results:[Movie]
}


struct Movie:Codable{
    let id:Int
    let media_type:String?
    let original_title:String?
    let overview:String?
    let title:String?
    let release_date:String?
    let vote_count:Int
    let poster_path:String?
    let vote_average:Double
}
