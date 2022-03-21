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
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.APIKey)") else {return}
        
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
        task.resume()
        
    }
    
    func getTrendingTv(completion: @escaping (Result<[Movie],Error>)  -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.APIKey)") else {return}
        
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
        task.resume()
        
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Movie],Error>)  -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.APIKey)") else {return}
        
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
        task.resume()
        
    }
    
    func getPopularMovies(completion: @escaping (Result<[Movie],Error>)  -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.APIKey)") else {return}
        
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
        task.resume()
        
    }
    
    
    
    func getTopRatedMovies(completion: @escaping (Result<[Movie],Error>)  -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.APIKey)") else {return}
        
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
        task.resume()
        
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Movie],Error>)  -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.APIKey)") else {return}
        
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
        task.resume()
        
    }
    
    
    func search(with query:String, completion: @escaping (Result<[Movie],Error>)  -> Void){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.APIKey)&query=\(query)") else {return}
        
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
        task.resume()
        
    }
}
 
