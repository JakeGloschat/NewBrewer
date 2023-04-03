//
//  NetworkController.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/3/23.
//

import Foundation

struct NetworkingController {
    
    static func fetchRandomBeer(completion: @escaping (Result<Beer, NetworkError>) -> Void) {
        guard let baseURL = URL(string: Constants.BeerList.beersBaseURL) else { completion(.failure(.InvalidURL)) ; return }
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path.append(Constants.BeerList.randomBeerPath)
        
        guard let finalURL = urlComponents?.url else { completion(.failure(.InvalidURL)) ; return }
        print("Fetch Random Beer Final URL: \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Fetch Random beer Status Code: \(response.statusCode)")
            }
            
            guard let data = data else { completion(.failure(.noData)) ; return }
            
            do {
                let topLevelArray = try JSONDecoder().decode([Beer].self, from: data)
                let beer = topLevelArray[0]
                completion(.success(beer))
            } catch {
                completion(.failure(.unableToDecode))
                return
            }
        }.resume()
    }
    
}
