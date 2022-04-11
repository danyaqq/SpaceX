//
//  NetworkServices.swift
//  SpaceX
//
//  Created by Даня on 10.04.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func getRockets(completion: @escaping (Result<[Rocket], Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    func getRockets(completion: @escaping (Result<[Rocket], Error>) -> Void) {
        guard let url = URL(string: "https://api.spacexdata.com/v4/rockets") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([Rocket].self, from: data)
                completion(.success(decodedData))
            } catch let err {
                completion(.failure(err))
            }
        }
        task.resume()
    }
    
}
