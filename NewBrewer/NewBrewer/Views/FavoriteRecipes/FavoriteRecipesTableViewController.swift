//
//  FavoriteRecipesTableViewController.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/10/23.
//

import UIKit

class FavoriteRecipesTableViewController: UITableViewController {

    // MARK: - Properties
    var viewModel: FavoriteRecipesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FavoriteRecipesViewModel(delegate: self)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favoritedBeers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteBeersCell", for: indexPath) as? FavoriteRecipesTableViewCell else { return UITableViewCell() }
        
        let beer = viewModel.beers[indexPath.row]
        let isFavorite = viewModel.favoritedBeers.first(where: { $0.beerId == beer.beerId })
        cell.configureCell(with: beer, isFavorited: isFavorite != nil, delegate: self)
        return cell
    }
   

 
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
    }
}

extension FavoriteRecipesTableViewController: FavoriteRecipesViewModelDelegate {
    func beersLoadedSuccessfully() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func beerRemovedSuccessfully() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension FavoriteRecipesTableViewController: FavoriteRecipesTableViewCellDelegate {
    func didTapFavorite(for beer: Beer) {
        let beerToRemove = BeerToSave(name: beer.name, description: beer.description, beerId: beer.beerId)
        viewModel.removeSavedBeer(beer: beerToRemove)
    }
}
