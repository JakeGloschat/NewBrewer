//
//  BeerIngredientCustomCell.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/4/23.
//

import UIKit

class IngredientsTableViewCell: UITableViewCell {
    
    
    // MARK: - Properties
    
    private let collectionView: UICollectionView
    private var dataSource: [Ingredients] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(dataSource: [Ingredients]) {
        self.dataSource = dataSource
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(IngredientsCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.reloadData()
    }
}


// MARK: - Extensions

extension IngredientsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! IngredientsCollectionViewCell
        cell.textLabel.text = dataSource[indexPath.row]
        return cell
    }
}
