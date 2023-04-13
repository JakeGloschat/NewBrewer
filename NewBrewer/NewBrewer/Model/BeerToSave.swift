//
//  BeerToSave.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/11/23.
//

import Foundation

class BeerToSave {
    
    enum Key {
        static let uuid = "uuid"
        static let name = "name"
        static let description = "description"
        static let beerId = "id"
        
    }
    
    let name: String
    let description: String
    let beerId: Int
    
    var dictionaryRepresentation: [String: AnyHashable] {
        
        [
         Key.name: self.name,
         Key.description: self.description,
         Key.beerId: self.beerId
        ]
    }
    
    init(name: String, description: String, beerId: Int) {
       
        self.name = name
        self.description = description
        self.beerId = beerId
    }
}

extension BeerToSave {
    convenience init?(fromDictionary dictionary: [String: Any]) {
        guard let name = dictionary[Key.name] as? String,
        let description = dictionary[Key.description] as? String,
        let beerId = dictionary[Key.beerId] as? Int else
        { print("Failed to initialize object") ; return nil }
        
        self.init(name: name, description: description, beerId: beerId)
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
