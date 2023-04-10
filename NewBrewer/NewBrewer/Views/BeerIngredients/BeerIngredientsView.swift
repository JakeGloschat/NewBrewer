//
//  BeerIngredientsView.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/4/23.
//

import UIKit

class BeerIngredientsViewController: UIViewController {
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        
    }
    
    
    // MARK: - Properties
    private let tableView = UITableView()
    private let tableViewCellReuseIdentifier = "TableViewCell"
    private let collectionViewCellReuseIdentifier = "CollectionViewCell"
    var beer: Beer?
    var viewModel: SearchBeerViewModel!
    
    // MARK: - Functions
    func setUpTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(IngredientsTableViewCell.self, forCellReuseIdentifier: tableViewCellReuseIdentifier)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

// MARK: - TableView Extension
extension BeerIngredientsViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellReuseIdentifier, for: indexPath) as! IngredientsTableViewCell
        guard let beer = beer else { return UITableViewCell() }
        cell.row = indexPath.row
        switch indexPath.row {
        case 0:
            cell.configure(data: beer.ingredients.malt, collectionViewDelegate: self, collectionViewDataSource: self)
        case 1:
            cell.configure(data: beer.ingredients.hops, collectionViewDelegate: self, collectionViewDataSource: self)
        case 2:
            cell.configure(data: [beer.ingredients.yeast], collectionViewDelegate: self, collectionViewDataSource: self)
        default:
            break
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension BeerIngredientsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let beer = beer else { return 0 }
        switch collectionView.tag {
        case 0:
            return beer.ingredients.malt.count
        case 1:
            return beer.ingredients.hops.count
        case 2:
            return beer.ingredients.yeast.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellReuseIdentifier, for: indexPath) as! IngredientsCollectionViewCell
        guard let beer = beer else { return UICollectionViewCell() }
        switch collectionView.tag {
        case 0:
            let malt = beer.ingredients.malt[indexPath.row]
            cell.configure(with: malt)
        case 1:
            let hops = beer.ingredients.hops[indexPath.row]
            cell.configure(with: hops)
        case 2:
            let ingredients = beer.ingredients
            cell.configure(with: ingredients )
        default:
            break
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
}
