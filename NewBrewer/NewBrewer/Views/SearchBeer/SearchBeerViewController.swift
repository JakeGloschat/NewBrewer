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
        viewModel = SearchBeerViewModel(delegate: self)
        // Do any additional setup after loading the view.
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

extension SearchBeerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // display number of beers
        return viewModel.beers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // configure each cell
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "beerCell", for: indexPath) as? BeerListTableViewCell else { return UITableViewCell() }
        
        let beer = viewModel.beers[indexPath.row]
        cell.configureCell(with: beer)
        return cell
    }
    
}
extension SearchBeerViewController: SearchBeerViewModelDelegate {
    func beersLoadedSuccessfully() {
        DispatchQueue.main.async {
            self.beerListTableView.reloadData()
        }
    }
}
