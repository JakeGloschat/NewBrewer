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
    var beer: BeerToSave?
    var beerFetch: Beer?
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//    }
//    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FavoriteRecipesViewModel(delegate: self)
        viewModel.loadFavorites()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favoritedBeers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteBeersCell", for: indexPath) as? FavoriteRecipesTableViewCell else { return UITableViewCell() }
        
        let beer = viewModel.favoritedBeers[indexPath.row]
        let isFavorite = viewModel.favoritedBeers.first(where: { $0.beerId == beer.beerId })
        cell.configureCell(with: beer, isFavorited: isFavorite != nil, delegate: self)
        return cell
    }
    
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toIngredientsDetail" {
       guard let indexPath = tableView.indexPathForSelectedRow,
             let destinationVC = segue.destination as? BeerIngredientsViewController else { return }
            let beer = viewModel.favoritedBeers[indexPath.row]
            destinationVC.viewModel = BeerIngredientsViewModel(delegate: destinationVC.self)
            destinationVC.viewModel.fetchBeerTosave(with: beer)
        }
    }
}

extension FavoriteRecipesTableViewController: FavoriteRecipesViewModelDelegate {
//    func beerLoadedSuccessfully() {
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
//    }
    
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
    func didTapFavorite(for beer: BeerToSave) {
        let beerToRemove = beer
        viewModel.removeSavedBeer(beer: beerToRemove)
    }
}
