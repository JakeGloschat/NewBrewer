//
//  BeerIngredientsView.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/4/23.
//

import UIKit

class BeerIngredients: UIViewController {
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Properties
    private let tableView = UITableView()
    private let tableViewCellReuseIdentifier = "TableViewCell"
    private let collectionViewCellReuseIdentifier = "CollectionViewCell"
    private var dataSource: UITableViewDiffableDataSource<Int, Int>!
    
    var beer: Beer?
    
    
    // MARK: - Functions
    func setUpTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(IngredientsTableViewCell.self, forCellReuseIdentifier: tableViewCellReuseIdentifier)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Int, Int>(tableView: tableView) { (tableView, indexPath, _) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: self.tableViewCellReuseIdentifier, for: indexPath) as! IngredientsTableViewCell
            guard let beer = beer else { return }
            switch indexPath.row {
            case 0:
                cell.configure(dataSource: self.beer?.ingredients.malt)
            case 1:
                cell.configure(dataSource: self.beer?.ingredients.hops)
            case 2:
                cell.configure(dataSource: [self.beer?.ingredients.yeast])
            }
            return cell
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapshot.appendSections([0])
        snapshot.appendItems([0, 1, 2], toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: - TableView Extension
extension UIViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

