//
//  Beer.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/3/23.
//

import Foundation

struct Beer: Codable {
    private enum CodingKeys: String, CodingKey {
        case beerId = "id"
        case name
        case tagline
        case description
        case image = "image_url"
        case abv
        case ibu
        case volume
        case boilVolume = "boil_volume"
        case method
        case ingredients
        case foodPairing = "food_pairing"
        case brewersTips = "brewers_tips"
    }
    
    let beerId: Int
    let name: String
    let tagline: String
    let description: String
    let image: String?
    let abv: Double
    let ibu: Double?
    let volume: Volume
    let boilVolume: BoilVolume
    let method: Method
    let ingredients: Ingredients
    let foodPairing: [String]
    let brewersTips: String

}

struct Volume: Codable {
    let value: Double
    let unit: String
}

struct BoilVolume: Codable {
    let value: Double
    let unit: String
}

struct Method: Codable {
    private enum CodingKeys: String, CodingKey {
        case mashTemp = "mash_temp"
        case fermentation
        case twist
    }
    
    let mashTemp: [MashTemp]
    let fermentation: Fermentation
    let twist: String?
}

struct MashTemp: Codable {
    let temp: Temp
    let duration: Double?
}

struct Temp: Codable {
    let value: Double
    let unit: String
}

struct Fermentation: Codable {
    let temp: Temp
    
}

struct Ingredients: Codable {
    let malt: [Malt]
    let hops: [Hops]
    let yeast: String
}

struct Malt: Codable {
    let name: String
    let amount: Amount
}

struct Amount: Codable {
    let value: Double
    let unit: String
}

struct Hops: Codable {
    let name: String
    let amount: Amount
    let add: String
    let attribute: String
}







// save name and id and description of beer to firebase
// that will populate their favorites list view
// perform a single fetch for the item when they click on said favorite.
