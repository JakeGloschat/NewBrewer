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
    
    // MARK: - Properties
    var viewModel: RandomBeerViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = RandomBeerViewModel(delegate: self)
        
    }
    
    private func updateUI() {
        guard let beer = viewModel.beer else { return }
        
        beerNameLabel.text = beer.name
        beerTaglineLabel.text = beer.tagline
        beerAbvLabel.text = "ABV: \(beer.abv)"
        beerIbuLabel.text = "IBU: \(beer.ibu ?? 0)"
        beerDescriptionLabel.text = beer.description
        
        viewModel.getBeerImage { image in
            DispatchQueue.main.async {
                self.beerImageView.image = image
                
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBeerDetailVC" {
            guard let destinationVC = segue.destination as? BeerIngredientsViewController else { return }
            let beer = viewModel.beer
            destinationVC.beer = beer
        }
    }
    
    // MARK: - Action
    @IBAction func toIngredientsButtonTapped(_ sender: Any) {
        //TODO: finish segue to ingredients
    }
    
    @IBAction func getRandomBeerButtonTapped(_ sender: Any) {
        viewModel.getRandomBeer()
    }
}

extension RandomBeerViewController: RandomBeerViewModelDelegate {
    func randomBeerLoadedSuccesfully() {
        DispatchQueue.main.async {
            self.updateUI()
        }
    }
}
