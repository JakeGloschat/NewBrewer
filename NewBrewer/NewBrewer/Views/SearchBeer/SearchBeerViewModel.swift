//
//  SearchBeerViewModel.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/5/23.
//

import Foundation

protocol SearchBeerViewModelDelegate: AnyObject {
    func beersLoadedSuccessfully()
    func beerSavedSuccessfully()
}

class SearchBeerViewModel { // This is a concrete type
    
    
    // MARK: - Properties
    private weak var delegate: SearchBeerViewModelDelegate?
    private var service: BeerServicable
    private var firebaseService: FirebaseServicable
    var beers: [Beer] = []
    var favoritedBeers: [BeerToSave] = []
    private var pagesFetched: [Int] = []
    private var currentSearchTerm = ""
    
    init(delegate: SearchBeerViewModelDelegate, beerService: BeerServicable = BeerService(), firebaseService: FirebaseServicable = FirebaseService()) {
        self.delegate = delegate
        self.service = beerService
        self.firebaseService = firebaseService
        fetchFavoritedBeers()
    }
    // MARK: - Functions
    
    func searchBeers(with search: String) {
        resetSearchState(with: search)
        service.fetchBeerBySearch(searchBeer: search, page: "1") { result in
            switch result {
            case .success(let beers):
                self.beers = beers
                self.delegate?.beersLoadedSuccessfully()
            case .failure(let failure):
                print(failure.errorDescription ?? "Where's the beer at?")
            }
        }
    }
    
    func fetchNextPage(wtih page: Int) {
        let nextPage = page + 1
        guard !pagesFetched.contains(nextPage) else { return }
        pagesFetched.append(nextPage)

        service.fetchBeerBySearch(searchBeer: currentSearchTerm, page: "\(nextPage)") { result in
            switch result {
            case .success(let beers):
                self.beers.append(contentsOf: beers)
                self.delegate?.beersLoadedSuccessfully()
            case .failure(let failure):
                print(failure.errorDescription ?? "No page for you")
            }
        }
    }
    
    func saveFavoriteBeer(beerToSave: BeerToSave) {
        if let indexOfBeer = favoritedBeers.firstIndex(of: beerToSave) {
            
            self.favoritedBeers.remove(at: indexOfBeer)
            deleteSavedBeer(beer: beerToSave)
            return
        }
        
        firebaseService.saveBeer(beer: beerToSave) { result in
            switch result {
            case .success(_):
                self.favoritedBeers.append(beerToSave)
                self.delegate?.beerSavedSuccessfully()
            case .failure(_):
                print("Something went wrong...?")
            }
        }
    }
    
    func fetchFavoritedBeers() {
        firebaseService.loadBeers { result in
            switch result {
            case .success(let beers):
                self.favoritedBeers = beers
            case .failure(_):
                break
            }
        }
    }
    
    func deleteSavedBeer(beer: BeerToSave) {
        firebaseService.delete(beer: beer) { result in
            switch result {
            case .success(_):
                self.delegate?.beerSavedSuccessfully()
            case .failure(_):
                print("Different error message")
            }
        }
    }
    
    private func resetSearchState(with search: String) {
        currentSearchTerm = search
        pagesFetched = [1]
    }
}

