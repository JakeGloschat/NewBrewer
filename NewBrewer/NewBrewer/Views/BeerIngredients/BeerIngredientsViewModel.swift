//
//  BeerIngredientsViewModel.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/11/23.
//

import Foundation

protocol BeerIngredienstViewModelDelegate: AnyObject {
    func beerSavedSuccuessfully()
}

class BeerIngredientsViewModel {
    
    var beer: Beer?
    var beerToSave: [BeerToSave] = []
    private var service: FirebaseServicable
    private weak var delegate: BeerIngredienstViewModelDelegate?
    //dependency injection
    init(firebaseService: FirebaseServicable = FirebaseService(), delegate: BeerIngredienstViewModelDelegate) {
        self.service = firebaseService
        self.delegate = delegate
    }
}
