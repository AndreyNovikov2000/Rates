//
//  NetworkService.swift
//  ExchangeRates
//
//  Created by Andrey Novikov on 9/5/20.
//  Copyright © 2020 Andrey Novikov. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    func getTimeSeriesRates(withRatePath ratePath: APISceme, response:@escaping (Result<[String: Any]?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func getTimeSeriesRates(withRatePath ratePath: APISceme, response: @escaping (Result<[String : Any]?, Error>) -> Void) {
        guard let url = collectUrl(withRatePath: ratePath) else { return }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                response(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                response(.success(dictionary))
            } catch {
                response(.failure(error))
            }
        }
        
        dataTask.resume()
    }
        
    private func collectUrl(withRatePath ratePath: APISceme) -> URL? {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = ratePath.path
        components.queryItems = ratePath.queryItems
                
        return components.url
    }
}

