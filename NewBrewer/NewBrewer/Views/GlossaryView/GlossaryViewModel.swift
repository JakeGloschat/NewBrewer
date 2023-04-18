//
//  GlossaryViewModel.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/17/23.
//

import Foundation
import SwiftSoup
import Collections
import OrderedCollections

protocol GlossaryViewModelDelegate: AnyObject {
    func glossaryLoadedSuccessfully()
}

class GlossaryViewModel {
    
    // MARK: - Properties
    private weak var delegate: GlossaryViewModelDelegate?
    
    init(delegate: GlossaryViewModelDelegate) {
        self.delegate = delegate
    }
    
   
    
    // MARK: - Functions
    
    func fetchGlossary() {
        let url = URL(string: "https://www.craftbeer.com/beer/beer-glossary")!
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            let glossary = self.parseBeerGlossary(data: data)
            print(OrderedDictionary(uniqueKeysWithValues: glossary.sorted(by: { $0.key < $1.key })))
            for (key, value) in glossary {
                print("\(key)", "\(value)")
            }
        }
        task.resume()
    }
    
    func parseBeerGlossary(data: Data) -> [String : String] {
        var glossary: [String : String] = [:]
        
        do {
            guard let html = String(data: data, encoding: .utf8) else {
                print("Failed to convert data to string")
                return [:]
            }
            
            let doc: Document = try SwiftSoup.parse(html)
            let entryDiv = try doc.select(".entry-content p > strong")
            
            for el in entryDiv.array() {
                guard let parent = el.parent(),
                      let children = parent.parent()?.children(),
                      let index = children.firstIndex(of: parent) else {
                    print("skipped")
                    continue
                }
                
                let next = children[index + 1]
                let key = try el.text()
                
                if next.tagName().lowercased() == "ol" {
                    glossary[key] = try next.text()
                    
                } else {
                    let allText = try parent.text()
                    glossary[key] = allText.dropFirst(key.count).trimmingCharacters(in: .whitespacesAndNewlines)
                }
            }
        } catch {
            print(error)
        }
        return glossary
    }
}

