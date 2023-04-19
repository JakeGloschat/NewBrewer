//
//  SearchBeerViewController.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/5/23.
//

import UIKit

class SearchBeerViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var beerSearchBar: UISearchBar!
    @IBOutlet weak var beerListTableView: UITableView!
    
    
    
    // MARK: - Properties
    var viewModel: SearchBeerViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beerSearchBar.delegate = self
        beerListTableView.dataSource = self
        beerListTableView.delegate = self
        viewModel = SearchBeerViewModel(delegate: self)
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toIngredientsVC" {
            guard let indexPath = beerListTableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? BeerIngredientsViewController else { return }
            let beer = viewModel.beers[indexPath.row]
            destinationVC.beer = beer
        }
    }
}

extension SearchBeerViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        viewModel.searchBeers(with: searchText)
    }
}

extension SearchBeerViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // display number of beers
        return viewModel.beers.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = indexPath.row
        if row.isMultiple(of: 24) {
            let page = row / 24
            viewModel.fetchNextPage(wtih: page)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // configure each cell
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "beerCell", for: indexPath) as? BeerListTableViewCell else { return UITableViewCell() }
        
        let beer = viewModel.beers[indexPath.row]
        let isFavorite = viewModel.favoritedBeers.first(where: { $0.beerId == beer.beerId })
        cell.configureCell(with: beer, isFavorited: isFavorite != nil, delegate: self)
        return cell
    }
}

extension SearchBeerViewController: SearchBeerViewModelDelegate {
    func beerSavedSuccessfully() {
        DispatchQueue.main.async {
            self.beerListTableView.reloadData()
        }
    }
    
    func beersLoadedSuccessfully() {
        DispatchQueue.main.async {
            self.beerListTableView.reloadData()
        }
    }
}

extension SearchBeerViewController: BeerListTableViewCellDelegate {
    func didTapFavorite(for beer: Beer) {
        let beerToSave = BeerToSave(name: beer.name, description: beer.description, beerId: beer.beerId, abv: beer.abv, ibu: beer.ibu)
        viewModel.saveFavoriteBeer(beerToSave: beerToSave)
    }
}
