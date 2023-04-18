//
//  GlossaryViewController.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/10/23.
//

import UIKit

class GlossaryViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var glossaryTableView: UITableView!
    
// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = GlossaryViewModel(delegate: self)
        glossaryTableView.delegate = self
        glossaryTableView.dataSource = self
        
        if let plistData = viewModel.loadPlistData() {
            viewModel.dataArray = plistData
        }
        glossaryTableView.reloadData()
    }
    
    // MARK: - Properties
    var viewModel: GlossaryViewModel!

    /*
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    */
    
    // MARK: - Action
    @IBAction func singOutButtonTapped(_ sender: Any) {
        let viewModel = CreateAccountViewModel()
        viewModel.signOutAccount()
    }
}

extension GlossaryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            viewModel.filteredDataSource = [:]
            glossaryTableView.reloadData()
            return
        }
        
        let dictionaryDataSource = Dictionary(uniqueKeysWithValues: viewModel.dataArray.map { ($0.key, $0.value)  })
        viewModel.filteredDataSource = dictionaryDataSource.filter({$0.key.lowercased().contains(searchText.lowercased())})
        glossaryTableView.reloadData()
    }
}

extension GlossaryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBar.text != "" {
            return viewModel.filteredDataSource.count
        } else {
            return viewModel.dataArray.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "glossaryCell", for: indexPath)
        
        let term: (key: String, value: String)
        if searchBar.text != "" {
            term = Array(viewModel.filteredDataSource)[indexPath.row]
        } else {
            term = viewModel.dataArray[indexPath.row]
        }
        
        var config = cell.defaultContentConfiguration()
        config.text = term.key
        config.secondaryText = term.value
        cell.contentConfiguration = config
        
        return cell
    }
}

extension GlossaryViewController: GlossaryViewModelDelegate {
    func glossaryLoadedSuccessfully() {
        DispatchQueue.main.async {
            self.glossaryTableView.reloadData()
        }
    }
}
