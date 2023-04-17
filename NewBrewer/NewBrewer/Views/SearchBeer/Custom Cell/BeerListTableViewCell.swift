//
//  BeerListTableViewCell.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/5/23.
//

import UIKit

protocol BeerListTableViewCellDelegate: AnyObject {
    func didTapFavorite(for beer: Beer)
}

class BeerListTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerAbvLabel: UILabel!
    @IBOutlet weak var beerIbueLabel: UILabel!
    @IBOutlet weak var beerDescriptionLabel: UILabel!
    @IBOutlet weak var beerFavoriteButton: UIButton!
    
    // MARK: - Properties
    weak var delegate: BeerListTableViewCellDelegate?
    var beer: Beer?
    // MARK: - Helper Functions
    override func prepareForReuse() {
        super.prepareForReuse()
        beerFavoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        beerNameLabel.text = nil
        beerAbvLabel.text = nil
        beerIbueLabel.text = nil
        beerDescriptionLabel.text = nil
    }
    
    func configureCell(with beer: Beer, isFavorited: Bool, delegate: BeerListTableViewCellDelegate) {
        self.beer = beer
        self.delegate = delegate
        beerNameLabel.text = beer.name
        beerAbvLabel.text = "ABV: \(beer.abv)"
        beerIbueLabel.text = "IBU: \(beer.ibu ?? 0.0)"
        beerDescriptionLabel.text = beer.description
        if isFavorited {
            beerFavoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
    
    // MARK: - Actions
    @IBAction func favoriteBeerButtonTapped(_ sender: Any) {
        guard let beer = self.beer else { return }
        delegate?.didTapFavorite(for: beer)
    }
}
 
