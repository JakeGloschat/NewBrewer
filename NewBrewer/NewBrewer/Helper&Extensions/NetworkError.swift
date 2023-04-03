//
//  NetworkError.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/3/23.
//

import Foundation

enum NetworkError: LocalizedError {
    
    case InvalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    case emptyArray
    case invalidStatusCode
    
    var errorDescription: String? {
        switch self {
        case .InvalidURL:
            return "Invalid URL. Check your endpoint."
        case .thrownError(let error):
            return "Thrown error. Error was \(error.localizedDescription)"
        case .noData:
            return "no data received from successful network fetch."
        case .unableToDecode:
            return "Unable to decode model object from data"
        case .emptyArray:
            return "Fetch returned empty array"
        case .invalidStatusCode:
            return "Fetch returned an unsuccesful status code.  Code was not 200"
        }
    }
}
