//
//  Constants.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/3/23.
//

import Foundation

struct Constants {
    
    struct BeerList {
        static let beersBaseURL = "https://api.punkapi.com/v2"
        static let allBeersPath = "/beers"
        static let randomBeerPath = "/beers/random"
        static let singleBeerPath = "https://api.punkapi.com/v2/beers/"
    }
    
    struct APIQueryKey {
        static let abvGreaterQuery = "abv_gt"
        static let ibuGreaterQuery = "ibu_gt"
        static let beerNameQuery = "beer_name"
        
    }
}
