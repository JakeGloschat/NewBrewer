//
//  SearchBeerViewModel.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/5/23.
//

import Foundation

protocol SearchBeerViewModelDelegate: AnyObject {
    func beersLoadedSuccessfully()
}

class SearchBeerViewModel { // This is a concrete type
    
    
    // MARK: - Properties
    private weak var delegate: SearchBeerViewModelDelegate?
    private var service: BeerServicable
    var beers: [Beer] = []
    
    init(delegate: SearchBeerViewModelDelegate, beerService: BeerServicable = BeerService()) {
        self.delegate = delegate
        self.service = beerService
    }
    // MARK: - Functions
    
    func searchBeers(with search: String) {
        service.fetchBeerBySearch(searchBeer: search) { result in
            switch result {
            case .success(let beers):
                self.beers = beers
                self.delegate?.beersLoadedSuccessfully()
            case .failure(let failure):
                print(failure.errorDescription ?? "Where's the beer at?")
            }
        }
    }
}

