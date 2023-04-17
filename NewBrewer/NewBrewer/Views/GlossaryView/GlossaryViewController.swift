//
//  GlossaryViewController.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/10/23.
//

import UIKit

class GlossaryViewController: UIViewController {
    
    var viewModel: GlossaryViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = GlossaryViewModel(delegate: self)
        viewModel.fetchGlossary()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
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
        <#code#>
    }
}

extension GlossaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}

extension GlossaryViewController: GlossaryViewModelDelegate {
    func glossaryLoadedSuccessfully() {
        
    }
}
