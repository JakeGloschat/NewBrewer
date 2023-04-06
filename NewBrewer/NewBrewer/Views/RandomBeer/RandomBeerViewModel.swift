//
//  RandomBeerViewModel.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/6/23.
//

import UIKit

protocol RandomBeerViewModelDelegate: AnyObject {
    func randomBeerLoadedSuccesfully()
}

class RandomBeerViewModel {
    
    // MARK: - Properties
    private weak var delegate: RandomBeerViewModelDelegate?
    private var service: BeerServicable
    var beer: Beer?
    
    init(delegate: RandomBeerViewModelDelegate, beerService: BeerServicable = BeerService()) {
        self.delegate = delegate
        self.service = beerService
    }
    
    func getRandomBeer() {
        service.fetchRandomBeer { result in
            switch result {
            case .success(let beer):
                self.beer = beer
                self.delegate?.randomBeerLoadedSuccesfully()
            case .failure(let failure):
                print(failure.errorDescription ?? "No beer for you!")
            }
        }
    }
    
    // add default image
    func getBeerImage(completion: @escaping (UIImage?) -> Void) {
        service.fetchImage(for: beer?.image) { result in
            switch result {
            case .success(let image):
                completion(image)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
}
