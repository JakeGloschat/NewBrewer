//
//  FIrebaseError.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/13/23.
//

import Foundation

enum FirebaseError: Error {
    case firebaseError(Error)
    case failedToUnrwapData
    case noDataFound
}
