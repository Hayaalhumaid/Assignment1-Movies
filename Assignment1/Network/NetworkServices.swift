//
//  NetworkServices.swift
//  Assignment1
//
//  Created by Haya Alhumaid on 9/13/19.
//  Copyright © 2019 HayaAlhumaid. All rights reserved.
//

import Foundation

enum Result<Value> {
    case success(Value)
    case failure(Error)
}

class NetworkServices {
    static func fetchMovieList(pageNumber: Int, completion: ((Result<MovieData>) -> Void)?) {
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=3020ef043d5c5964a903081a5bf166fc&language=en-US&page=\(pageNumber)&region=US")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            DispatchQueue.main.async {
                if let error = responseError {
                    completion?(.failure(error))
                } else if let jsonData = responseData {
                    let decoder = JSONDecoder()
                    do {
                        let reports = try decoder.decode(MovieData.self, from: jsonData)
                        completion?(.success(reports))
                    } catch {
                        completion?(.failure(error))
                    }
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                    completion?(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}
