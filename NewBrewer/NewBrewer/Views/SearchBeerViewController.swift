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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "beerCell", for: indexPath)
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
