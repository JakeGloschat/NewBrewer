//
//  RandomBeerViewController.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/6/23.
//

import UIKit

class RandomBeerViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var beerImageView: ServiceRequestingImageView!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerTaglineLabel: UILabel!
    @IBOutlet weak var beerAbvLabel: UILabel!
    @IBOutlet weak var beerIbuLabel: UILabel!
    @IBOutlet weak var beerDescriptionLabel: UILabel!
    @IBOutlet weak var toIngredientsButton: UIButton!
    @IBOutlet weak var getRandomBeerButton: UIButton!
    @IBOutlet weak var favoriteBeerButton: UIButton!
    
    // MARK: - Properties
    var viewModel: RandomBeerViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = RandomBeerViewModel(delegate: self)
        viewModel.getRandomBeer()
    }
    
    private func updateUI() {
        guard let beer = viewModel.beer else { return }
        
        beerNameLabel.text = beer.name
        beerTaglineLabel.text = beer.tagline
        beerAbvLabel.text = "ABV: \(beer.abv)"
        beerIbuLabel.text = "IBU: \(beer.ibu ?? 0)"
        beerDescriptionLabel.text = beer.description
        favorited()
        viewModel.getBeerImage { image in
            DispatchQueue.main.async {
                self.beerImageView.image = image
                
            }
        }
    }
    
    // MARK: - Helper Function
    
    func favorited() {
        let beer = viewModel.beer
        let isFavorite = viewModel.saveBeer.first(where: { $0.beerId == beer?.beerId })
        if isFavorite != nil {
            favoriteBeerButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favoriteBeerButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    func didTapFavorite(for beer: Beer) {
        viewModel.isFavorite.toggle()
        favorited()
        let beerToSave = BeerToSave(name: beer.name, description: beer.description, beerId: beer.beerId, abv: beer.abv, ibu: beer.ibu)
        viewModel.saveFavoriteBeer(beerToSave: beerToSave)
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBeerIngredientsVC" {
            guard let destinationVC = segue.destination as? BeerIngredientsViewController else { return }
            let beer = viewModel.beer
            destinationVC.beer = beer
        }
    }
    
    // MARK: - Action
    @IBAction func toIngredientsButtonTapped(_ sender: Any) {
        //TODO: decide if action is even needed
    }
    
    @IBAction func getRandomBeerButtonTapped(_ sender: Any) {
        viewModel.getRandomBeer()
    }
    
    @IBAction func favoriteBeerButtonTapped(_ sender: Any) {
        guard let beer = viewModel.beer else { return }
        didTapFavorite(for: beer)
    }
}

extension RandomBeerViewController: RandomBeerViewModelDelegate {
    func beerSavedSuccesfully() {
        DispatchQueue.main.async {
            self.updateUI()
        }
    }
    
    func randomBeerLoadedSuccesfully() {
        DispatchQueue.main.async {
            self.updateUI()
        }
    }
}
