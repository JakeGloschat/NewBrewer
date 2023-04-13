//
//  BeerIngredientsViewModel.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/13/23.
//

import Foundation

protocol BeerIngredientsViewModelDelegate: AnyObject {
    func beerLoadedSuccessfully()
}

class BeerIngredientsViewModel {
    
    // MARK: - Properties
    private weak var delegate: BeerIngredientsViewModelDelegate?
    private var service: BeerServicable
    var beer: Beer?
    
    init(delegate: BeerIngredientsViewModelDelegate, service: BeerServicable = BeerService()) {
        self.delegate = delegate
        self.service = service
    }
    
    func fetchBeer(with beer: Beer) {
        service.fetchSingleBeer(for: beer) { result in
            switch result {
            case .success(let beer):
                self.beer = beer
                self.delegate?.beerLoadedSuccessfully()
            case .failure(let failure):
                print(failure.errorDescription ?? "Beer not found")
            }
        }
    }
}
