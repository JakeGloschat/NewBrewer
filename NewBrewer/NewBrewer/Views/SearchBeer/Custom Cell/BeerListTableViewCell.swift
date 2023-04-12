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
    @IBOutlet weak var beerFavoriteButton: UIButton!
    
    // MARK: - Properties
    var viewModel: SearchBeerViewModel?
    var beer: Beer?
    // MARK: - Helper Function
    func configureCell(with beer: Beer, viewModel: SearchBeerViewModel) {
        self.beer = beer
        self.viewModel = viewModel
        beerNameLabel.text = beer.name
        beerAbvLabel.text = "ABV: \(beer.abv)"
        beerIbueLabel.text = "IBU: \(beer.ibu ?? 0.0)"
        beerDescriptionLabel.text = beer.description
    }
    
    // MARK: - Actions
    @IBAction func favoriteBeerButtonTapped(_ sender: Any) {
        guard let beer = self.beer else { return }
        self.viewModel!.saveFavoriteBeer(beerToSave: BeerToSave(name: beer.name, description: beer.description, beerId: beer.beerId))
    }
}
// do a cell viewModel with a checkFavorite that makes a call to see if an id is there.
