//
//  APICaller.swift
//  Netflix
//
//  Created by Mikail on 17/03/2022.
//

import Foundation

struct Constants{
   static let APIKey = "99fef6c15216a0a693e225ca3223f34e"
    static let baseURL = "https://api.themoviedb.org"
}

enum APIError{
    case failedTogetData
}

class APICaller{
    static let shared = APICaller()
    
    
    func getTrendingMovies(completion: @escaping (Result<[Movie],Error>)  -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/all/day?api_key=\(Constants.APIKey)") else {return}
        
        let task  = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data , error == nil else {return}
            do{
                let results = try  JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
            }
            
            catch{
                completion(.failure(error))
            }
        }
        task.resume()    }
    
}
 
