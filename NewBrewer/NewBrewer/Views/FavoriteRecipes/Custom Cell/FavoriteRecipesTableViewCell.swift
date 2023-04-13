//
//  FavoriteRecipesTableViewCell.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/13/23.
//

import UIKit

protocol FavoriteRecipesTableViewCellDelegate: AnyObject {
    func didTapFavorite(for beer: BeerToSave)
}

class FavoriteRecipesTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var beerNameLabl: UILabel!
    @IBOutlet weak var beerAbvLabel: UILabel!
    @IBOutlet weak var beerIbuLabel: UILabel!
    @IBOutlet weak var beerDescriptionLabel: UILabel!
    @IBOutlet weak var favoriteBeerButton: UIButton!
    
    
    // MARK: - Properties
    weak var delegate: FavoriteRecipesTableViewCellDelegate?
    var savedBeer: BeerToSave?
    
    // MARK: - Helper Functions

    func configureCell(with beer: BeerToSave, isFavorited: Bool, delegate: FavoriteRecipesTableViewCellDelegate) {
        self.savedBeer = beer
        self.delegate = delegate
        beerNameLabl.text = beer.name
        beerAbvLabel.text = "ABV: \(beer.abv)"
        beerIbuLabel.text = "IBU: \(beer.ibu ?? 0.0)"
        beerDescriptionLabel.text = beer.description
        if isFavorited {
            favoriteBeerButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
    
    // MARK: - Action
    @IBAction func favoriteBeerButtonTapped(_ sender: Any) {
        guard let beer = self.savedBeer else { return }
        delegate?.didTapFavorite(for: beer)
    }
}
