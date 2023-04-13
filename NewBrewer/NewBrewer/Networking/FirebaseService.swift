//
//  FirebaseService.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/10/23.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

//Make it's own file
enum FirebaseError: Error {
    case firebaseError(Error)
    case failedToUnrwapData
    case noDataFound
}

protocol FirebaseServicable {
    func saveBeer(beer: BeerToSave, completion: @escaping (Result<Bool, FirebaseError>) -> Void)
    func delete(beer: BeerToSave, completion: @escaping (Result<Bool, FirebaseError>) -> Void)
    func loadBeers(completion: @escaping (Result<[BeerToSave], FirebaseError>) -> Void)
}

struct FirebaseService: FirebaseServicable {
    
    // MARK: - Properties
    let ref = Firestore.firestore()
   // let storage = Storage.storage().reference()
    // Storage is only used for images
    
    // MARK: - Functions
    func saveBeer(beer: BeerToSave, completion: @escaping (Result<Bool, FirebaseError>) -> Void) {
        
        ref.collection("beers").document("\(beer.beerId)").setData(beer.dictionaryRepresentation) { error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.firebaseError(error)))
            }
            completion(.success(true))
        }
    }
    
    func delete(beer: BeerToSave, completion: @escaping (Result<Bool, FirebaseError>) -> Void) {
        ref.collection("beers").document("\(beer.beerId)").delete { error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.firebaseError(error)))
            }
            completion(.success(true))
        }
    }
    
    func loadBeers(completion: @escaping (Result<[BeerToSave], FirebaseError>) -> Void) {
        ref.collection("beers").getDocuments { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.firebaseError(error)))
                return
            }
            
            guard let docSnapshotArray = snapshot?.documents else { completion(.failure(.noDataFound)) ; return }
            
            let dictionaryArray = docSnapshotArray.compactMap { $0.data() }
            let beers = dictionaryArray.compactMap { BeerToSave(fromDictionary: $0)}
            completion(.success(beers))
        }
    }
}
