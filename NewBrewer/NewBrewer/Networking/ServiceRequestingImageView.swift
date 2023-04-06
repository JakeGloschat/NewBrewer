//
//  ServiceRequestingImageView.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/6/23.
//

import UIKit

class ServiceRequestingImageView: UIImageView {
    
    private var service: BeerServicable
    var beer: Beer?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func fetchImage(using beer: Beer) {
        service.fetchImage(for: beer.image) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.image = image
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
