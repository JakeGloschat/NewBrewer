//
//  FirebaseService.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/10/23.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

protocol FirebaseSyncable {
    func saveBeer(beer: BeerToSave, with uuid: String, completion: @escaping (Result<Bool, NetworkError>) -> Void)
    func delete(beer: BeerToSave)
}

struct FirebaseService: FirebaseSyncable {
    
    // MARK: - Properties
    let ref = Firestore.firestore()
   // let storage = Storage.storage().reference()
    // Storage is only used for images
    
    // MARK: - Functions
    func saveBeer(beer: BeerToSave, with uuid: String, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        
        ref.collection("beers").document(beer.uuid).setData(beer.dictionaryRepresentation) { error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(NetworkError.thrownError(error)))
            }
            completion(.success(true))
        }
    }
    
    func delete(beer: BeerToSave) {
        ref.collection("beers").document(beer.uuid).delete()
    }
}
