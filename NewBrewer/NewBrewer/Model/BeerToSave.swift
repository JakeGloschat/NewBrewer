//
//  BeerToSave.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/11/23.
//

import Foundation

class BeerToSave {
    
    enum Key {
        static let name = "name"
        static let description = "description"
        static let beerId = "id"
        static let abv = "abv"
        static let ibu = "ibu"
        
        
    }
    
    let name: String
    let description: String
    let beerId: Int
    let abv: Double
    let ibu: Double?
    
    
    var dictionaryRepresentation: [String: AnyHashable] {
        
        [
         Key.name: self.name,
         Key.description: self.description,
         Key.beerId: self.beerId,
         Key.abv: self.abv,
         Key.ibu: self.ibu
        ]
    }
    
    init(name: String, description: String, beerId: Int, abv: Double, ibu: Double?) {
       
        self.name = name
        self.description = description
        self.beerId = beerId
        self.abv = abv
        self.ibu = ibu
    }
}

extension BeerToSave {
    convenience init?(fromDictionary dictionary: [String: Any]) {
        guard let name = dictionary[Key.name] as? String,
        let description = dictionary[Key.description] as? String,
        let beerId = dictionary[Key.beerId] as? Int,
        let abv = dictionary[Key.abv] as? Double,
        let ibu = dictionary[Key.ibu] as? Double else
        { print("Failed to initialize object") ; return nil }
        
        self.init(name: name, description: description, beerId: beerId, abv: abv, ibu: ibu)
    }
}

extension BeerToSave: Equatable {
    static func == (lhs: BeerToSave, rhs: BeerToSave) -> Bool {
        return lhs.beerId == rhs.beerId
    }
}





// save name and id and description of beer to firebase
// that will populate their favorites list view
// perform a single fetch for the item when they click on said favorite.
