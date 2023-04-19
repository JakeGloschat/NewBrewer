//
//  FavoriteRecipesViewModel.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/11/23.
//

import Foundation

protocol FavoriteRecipesViewModelDelegate: AnyObject {
    func beersLoadedSuccessfully()
    func beerRemovedSuccessfully()
}

class FavoriteRecipesViewModel {
    
    // MARK: - Properties
    var favoritedBeers: [BeerToSave] = []
    var beers: [Beer] = []
    var beer: Beer?
    private var service: FirebaseServicable
    private var beerService: BeerServicable
    private weak var delegate: FavoriteRecipesViewModelDelegate?
    
    // dependency injection
    init(firebaseService: FirebaseServicable = FirebaseService(), beerService: BeerServicable = BeerService(), delegate: FavoriteRecipesViewModelDelegate) {
        self.service = firebaseService
        self.delegate = delegate
        self.beerService = beerService
    }
    
    // MARK: - Functions
    
    func loadFavorites () {
        service.loadBeers { result in
            switch result {
            case .success(let beers):
                self.favoritedBeers = beers
                self.delegate?.beersLoadedSuccessfully()
            case .failure(_):
                break
            }
        }
    }
    
    func removeSavedBeer(beer: BeerToSave) {
        service.delete(beer: beer) { result in
            switch result {
            case .success(_):
                guard let indexOfBeer = self.favoritedBeers.firstIndex(of: beer) else { return }
                
                self.favoritedBeers.remove(at: indexOfBeer)
                self.delegate?.beerRemovedSuccessfully()
            case .failure(_):
                print("Beer wasn't removed successfully.")
            }
        }
    }
}
