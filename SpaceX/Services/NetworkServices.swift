//
//  NetworkServices.swift
//  SpaceX
//
//  Created by Даня on 10.04.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func getRockets(completion: @escaping (Result<[Rocket], Error>) -> Void)
    func getLaunches(rocketId: String, completion: @escaping (Result<[LaunchModel], Error>) -> Void)
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
    
    func getLaunches(rocketId: String, completion: @escaping (Result<[LaunchModel], Error>) -> Void) {
        guard let url = URL(string: "https://api.spacexdata.com/v4/launches/query") else {
            return
        }
        
        let parameters: [String: Any] = ["query": ["rocket" : rocketId], "options" : ["pagination" : false, "select" : "name date_local success", "sort": "-date_local"]]
        let body = try? JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let data = data else {
                return
            }
            print(String(data: data, encoding: .utf8) ?? "Nil")
            do {
                let decodedData = try JSONDecoder().decode(Launches.self, from: data)
                print(decodedData)
                completion(.success(decodedData.docs))
            } catch let err {
                completion(.failure(err))
            }
        }
        task.resume()
    }
    
}
