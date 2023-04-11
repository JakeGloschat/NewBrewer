//
//  BeerToSave.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/11/23.
//

import Foundation

class BeerToSave {
    
    enum Key {
        static let beerId = "beerId"
        static let name = "name"
        static let description = "description"
    }
    
    let beerId: Int
    let name: String
    let description: String
    
    var dictionaryRepresentation: [String: AnyHashable] {
        
        [Key.beerId: self.beerId,
         Key.name: self.name,
         Key.description: self.description]
    }
    
    init(beerId: Int, name: String, description: String) {
        self.beerId = beerId
        self.name = name
        self.description = description
    }
}

extension BeerToSave {
    convenience init?(fromDictionary dictionary: [String: Any]) {
        guard let beerId = dictionary[Key.beerId] as? Int,
        let name = dictionary[Key.name] as? String,
        let description = dictionary[Key.description] as? String else
        { print("Failed to initialize object") ; return nil }
        
        self.init(beerId: beerId, name: name, description: description)
    }
}
