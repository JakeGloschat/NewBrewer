//
//  FavoriteRecipesViewModel.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/11/23.
//

import Foundation

protocol FavoriteRecipesViewModelDelegate: AnyObject {
    func beersLoadedSuccessfully()
}

class FavoriteRecipesViewModel {
    
    // MARK: - Properties
    var beers: [BeerToSave] = []
    private var service: FirebaseServicable
    private weak var delegate: FavoriteRecipesViewModelDelegate?
    // dependency injection
    init(firebaseService: FirebaseServicable = FirebaseService(), delegate: FavoriteRecipesViewModelDelegate) {
        self.service = firebaseService
        self.delegate = delegate
    }
    
    // MARK: - Functions

}
