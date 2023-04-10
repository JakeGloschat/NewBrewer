//
//  BeerListTableViewCell.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/5/23.
//

import UIKit

class BeerListTableViewCell: UITableViewCell {

// MARK: - Outlets
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerAbvLabel: UILabel!
    @IBOutlet weak var beerIbueLabel: UILabel!
    @IBOutlet weak var beerDescriptionLabel: UILabel!
    
    // MARK: - Helper Function
    func configureCell(with beer: Beer) {
        beerNameLabel.text = beer.name
        beerAbvLabel.text = "ABV: \(beer.abv)"
        beerIbueLabel.text = "IBU: \(beer.ibu ?? 0.0)"
        beerDescriptionLabel.text = beer.description
    }
}
