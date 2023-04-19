//
//  FirebaseService.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/10/23.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

protocol FirebaseServicable {
    func saveBeer(beer: BeerToSave, completion: @escaping (Result<Bool, FirebaseError>) -> Void)
    func delete(beer: BeerToSave, completion: @escaping (Result<Bool, FirebaseError>) -> Void)
    func loadBeers(completion: @escaping (Result<[BeerToSave], FirebaseError>) -> Void)
}

struct FirebaseService: FirebaseServicable {
    
    // MARK: - Properties
    let ref = Firestore.firestore()

    // MARK: - Functions
    func saveBeer(beer: BeerToSave, completion: @escaping (Result<Bool, FirebaseError>) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        ref.collection("users").document(userId).collection("beers").document("\(beer.beerId)").setData(beer.dictionaryRepresentation) { error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.firebaseError(error)))
            }
            completion(.success(true))
        }
    }
    
    func delete(beer: BeerToSave, completion: @escaping (Result<Bool, FirebaseError>) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        ref.collection("users").document(userId).collection("beers").document("\(beer.beerId)").delete { error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.firebaseError(error)))
            }
            completion(.success(true))
        }
    }
    
    func loadBeers(completion: @escaping (Result<[BeerToSave], FirebaseError>) -> Void) {
            guard let userId = Auth.auth().currentUser?.uid else { return }
        
        ref.collection("users").document(userId).collection("beers").getDocuments { snapshot, error in
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
