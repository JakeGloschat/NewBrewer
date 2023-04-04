//
//  API Service.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/4/23.
//

import Foundation

struct APIService {
    
    func perform(_ request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse {
                print("\(response.statusCode)")
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            completion(.success(data))
        }.resume()
    }
}
