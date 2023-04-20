//
//  BeerIngredientCustomCell.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/4/23.
//

import UIKit

//class IngredientsTableViewCell: UITableViewCell {
//    
//    // MARK: - Properties
//    
//    private let collectionView: UICollectionView
//    var row: Int = 0
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.scrollDirection = .horizontal
//        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
//        
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        contentView.addSubview(collectionView)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
//        ])
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func configure(data: [Any], collectionViewDelegate: UICollectionViewDelegate, collectionViewDataSource: UICollectionViewDataSource) {
//        collectionView.tag = row
//        collectionView.dataSource = collectionViewDataSource
//        collectionView.delegate = collectionViewDelegate
//        collectionView.register(IngredientsCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
//        collectionView.reloadData()
//    }
//}
