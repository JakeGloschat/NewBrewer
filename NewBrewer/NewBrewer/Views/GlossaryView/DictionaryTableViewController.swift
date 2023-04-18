//
//  DictionaryTableViewController.swift
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
        
        viewModel.fetchGlossary()
    }
    
    // MARK: - Properties
    var viewModel: GlossaryViewModel!
    var filteredDataSource = [String : String]()
    var dataArray: [(key: String, value: String)] = []
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
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
}

extension GlossaryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    }

    
}

extension GlossaryViewController: GlossaryViewModelDelegate {
    func glossaryLoadedSuccessfully() {
        
    }
}
