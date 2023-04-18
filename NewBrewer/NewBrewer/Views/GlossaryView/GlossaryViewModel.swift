//
//  GlossaryViewModel.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/17/23.
//

import Foundation


protocol GlossaryViewModelDelegate: AnyObject {
    func glossaryLoadedSuccessfully()
}

class GlossaryViewModel {
    
    // MARK: - Properties
    private weak var delegate: GlossaryViewModelDelegate?
    var filteredDataSource = [String : String]()
    var dataArray: [(key: String, value: String)] = []
    
    init(delegate: GlossaryViewModelDelegate) {
        self.delegate = delegate
    }
    
    
    
    // MARK: - Functions
    func loadPlistData() -> [(key: String, value: String)]? {
        if let plistURL = Bundle.main.url(forResource: "BeerGlossary", withExtension: "plist") {
            do {
                let plistData = try Data(contentsOf: plistURL)
                
                if let plistDictionary = try PropertyListSerialization.propertyList(from: plistData, options: [], format: nil) as? [String : String] {
                    return Array(plistDictionary)
                }
            } catch {
                print(error)
            }
        }
        return nil
    }
}

