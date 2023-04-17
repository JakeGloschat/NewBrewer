//
//  NetworkController.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/3/23.
//

import UIKit

protocol BeerServicable {
    func fetchRandomBeer(completion: @escaping (Result<Beer, NetworkError>) -> Void)
    func fetchBeerBySearch(searchBeer: String, completion: @escaping (Result<[Beer], NetworkError>) -> Void)
    func fetchImage(for item: String?, completion: @escaping (Result<UIImage, NetworkError>) -> Void)
    func fetchSingleBeer(for beer: Beer, completion: @escaping (Result<Beer, NetworkError>) -> Void)
    func fetchSingleBeerIngredients(for beer: BeerToSave, completion: @escaping (Result<Beer, NetworkError>) -> Void)
}

struct BeerService: BeerServicable { //This is a concrete type
   
    private let service = APIService()
    
    func fetchRandomBeer(completion: @escaping (Result<Beer, NetworkError>) -> Void) {
        guard let baseURL = URL(string: Constants.BeerList.beersBaseURL) else { completion(.failure(.InvalidURL)) ; return }
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path.append(Constants.BeerList.randomBeerPath)
        
        guard let finalURL = urlComponents?.url else { completion(.failure(.InvalidURL)) ; return }
        print("Fetch Random Beer Final URL: \(finalURL)")
        
        let request = URLRequest(url: finalURL)
        service.perform(request) { result in
            switch result {
            case .success(let data):
                do {
                    let topLevelArray = try JSONDecoder().decode([Beer].self, from: data)
                    let beer = topLevelArray[0]
                    completion(.success(beer))
                } catch {
                    completion(.failure(.unableToDecode))
                }
            case .failure(let failure):
                completion(.failure(.thrownError(failure)))
                
            }
        }
    }
    
    func fetchBeerBySearch(searchBeer: String, completion: @escaping (Result<[Beer], NetworkError>) -> Void) {
        guard let baseURL = URL(string: Constants.BeerList.beersBaseURL) else { completion(.failure(.InvalidURL)) ; return }
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path.append(Constants.BeerList.allBeersPath)
        
        // I want to dynamically create URL based on what the user searches by.
        // by name
        // by ABV
        
        if let abv = Double(searchBeer) {
            let beerABVSearchQuery = URLQueryItem(name: Constants.APIQueryKey.abvGreaterQuery, value: "\(abv)")
            urlComponents?.queryItems = [beerABVSearchQuery]
            
        } else if searchBeer != "" {
            let beerNameSearchQuery = URLQueryItem(name: Constants.APIQueryKey.beerNameQuery, value: searchBeer)
            urlComponents?.queryItems = [beerNameSearchQuery]
        }
        
        guard let finalURL = urlComponents?.url else { completion(.failure(.InvalidURL)) ; return }
        print("Fetch Beers Final URL: \(finalURL)")
        
        let request = URLRequest(url: finalURL)
        service.perform(request) { result in
            switch result {
            case .success(let data):
                do {
                    let topLevel = try JSONDecoder().decode([Beer].self, from: data)
                    completion(.success(topLevel))
                } catch {
                    completion(.failure(.unableToDecode))
                }
            case .failure(let failure):
                completion(.failure(.thrownError(failure)))
            }
        }
    }
    
    func fetchImage(for item: String?, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        guard let item = item,
              let finalURL = URL(string: item) else { completion(.failure(.InvalidURL)) ; return }
        print("Image Fetch Final URL: \(finalURL)")
        
        let request = URLRequest(url: finalURL)
        service.perform(request) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else { completion(.failure(.unableToDecode)) ; return }
                completion(.success(image))
            case .failure(let failure):
                completion(.failure(.thrownError(failure)))
            }
        }
    }
    
    func fetchSingleBeer(for beer: Beer, completion: @escaping (Result<Beer, NetworkError>) -> Void) {
        guard let baseURL = URL(string: Constants.BeerList.singleBeerPath) else { completion(.failure(.InvalidURL)) ; return }
        
        var urlComponents = URLComponents(url:baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path.append("\(beer.beerId)")
        
        guard let finalURL = urlComponents?.url else { completion(.failure(.InvalidURL)) ; return }
        print("Fetch Beer Final URL: \(finalURL)")
        
        let request = URLRequest(url: finalURL)
        service.perform(request) { result in
            switch result {
            case .success(let data):
                do {
                    let topLevelArray = try JSONDecoder().decode([Beer].self, from: data)
                    let beer = topLevelArray[0]
                    completion(.success(beer))
                } catch {
                    completion(.failure(.unableToDecode))
                }
            case .failure(let failure):
                completion(.failure(.thrownError(failure)))
            }
        }
    }
    
    func fetchSingleBeerIngredients(for beer: BeerToSave, completion: @escaping (Result<Beer, NetworkError>) -> Void) {
        guard let baseURL = URL(string: Constants.BeerList.singleBeerPath) else { completion(.failure(.InvalidURL)) ; return }
        
        var urlComponents = URLComponents(url:baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path.append("\(beer.beerId)")
        
        guard let finalURL = urlComponents?.url else { completion(.failure(.InvalidURL)) ; return }
        print("Fetch Beer Final URL: \(finalURL)")
        
        let request = URLRequest(url: finalURL)
        service.perform(request) { result in
            switch result {
            case .success(let data):
                do {
                    let topLevelArray = try JSONDecoder().decode([Beer].self, from: data)
                    let beer = topLevelArray[0]
                    completion(.success(beer))
                } catch {
                    completion(.failure(.unableToDecode))
                }
            case .failure(let failure):
                completion(.failure(.thrownError(failure)))
            }
        }
    }
}
