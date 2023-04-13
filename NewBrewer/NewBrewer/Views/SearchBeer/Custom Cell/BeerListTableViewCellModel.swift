//
//  BeerListTableViewCellModel.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/12/23.
//

import Foundation
import FirebaseFirestore

protocol BeerListTableViewCellModelDelegate: AnyObject {
    func favoritesCheckedSuccesfully()
}

struct BeerListTableViewCellModel {
    
    // MARK: - Properties
    private weak var delegate: BeerListTableViewCellModelDelegate?
    private var service: FirebaseServicable
//    var beers: [BeerToSave]
    let ref = Firestore.firestore()
    
    init(delegate: BeerListTableViewCellModelDelegate, firebaseService: FirebaseServicable = FirebaseService()) {
        self.delegate = delegate
        self.service = firebaseService
    }
    
//    func checkSavedBeers() {
//        guard let beers = beers else { return }
//        ref.collection("beers").getDocuments { snapshot, error in
//
//            //check for erros
//            if error == nil {
//                if let snapshot = snapshot {
//                    for doc in snapshot.documents {
//                        if beers.beerId == nil { return }
//                    }
//                }
//            }
//            else {
//
//            }
//        }
//
//    }
}
