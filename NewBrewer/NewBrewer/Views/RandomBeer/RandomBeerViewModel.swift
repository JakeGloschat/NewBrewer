//
//  RandomBeerViewModel.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/6/23.
//

import UIKit

protocol RandomBeerViewModelDelegate: AnyObject {
    func randomBeerLoadedSuccesfully()
    func beerSavedSuccesfully()
}

class RandomBeerViewModel {
    
    // MARK: - Properties
    private weak var delegate: RandomBeerViewModelDelegate?
    private var service: BeerServicable
    private var firebaseService: FirebaseServicable
    var beer: Beer?
    var saveBeer: [BeerToSave] = []
    var isFavorite: Bool = false
    
    init(delegate: RandomBeerViewModelDelegate, beerService: BeerServicable = BeerService(), firebaseService: FirebaseServicable = FirebaseService()) {
        self.delegate = delegate
        self.service = beerService
        self.firebaseService = firebaseService
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
    
    func saveFavoriteBeer(beerToSave: BeerToSave) {
        if let indexOfBeer = saveBeer.firstIndex(of: beerToSave) {
            
            self.saveBeer.remove(at: indexOfBeer)
            deleteSavedBeer(beer: beerToSave)
            return
        }
        
        firebaseService.saveBeer(beer: beerToSave) { result in
            switch result {
            case .success(_):
                self.saveBeer.append(beerToSave)
                self.delegate?.beerSavedSuccesfully()
            case .failure(_):
                print("Random beer NOT saved succesfully")
            }
        }
    }
    
    func deleteSavedBeer(beer: BeerToSave) {
        firebaseService.delete(beer: beer) { result in
            switch result {
            case .success(_):
                self.delegate?.beerSavedSuccesfully()
            case .failure(_):
                print("Different error message")
            }
        }
    }
}
