//
//  IngredientsCollectionViewCustomCell.swift
//  NewBrewer
//
//  Created by Jake Gloschat on 4/4/23.
//

import UIKit

class IngredientsCollectionViewCell: UICollectionViewCell {
    
    var ingredients: Ingredients?
    
    
    let nameLabel = UILabel()
    let amountLabel = UILabel()
    let addTimeLabel = UILabel()
    let attributeLabel = UILabel()
    
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBlue
        contentView.addSubview(nameLabel)
        contentView.addSubview(amountLabel)
        contentView.addSubview(addTimeLabel)
        contentView.addSubview(attributeLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = .white
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
        ])
        
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.textColor = .white
        amountLabel.font = UIFont.systemFont(ofSize: 14)
        NSLayoutConstraint.activate([
            amountLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            amountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
        ])
        
        addTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        addTimeLabel.textColor = .white
        addTimeLabel.font = UIFont.systemFont(ofSize: 14)
        NSLayoutConstraint.activate([
            addTimeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            addTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
        ])
        
        attributeLabel.translatesAutoresizingMaskIntoConstraints = false
        attributeLabel.textColor = .white
        NSLayoutConstraint.activate([
            attributeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            attributeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with malt: Malt) {
        nameLabel.text = malt.name
        amountLabel.text = "\(malt.amount.value) \(malt.amount.unit)"
        addTimeLabel.text = ""
        attributeLabel.text = ""
    }
    
    func configure(with hops: Hops) {
        nameLabel.text = hops.name
        amountLabel.text = "\(hops.amount.value) \(hops.amount.unit)"
        addTimeLabel.text = "\(hops.add)"
        attributeLabel.text = hops.attribute
    }
    
    func configure(with ingredients: Ingredients) {
        let yeast = ingredients.yeast
        nameLabel.text = yeast
        amountLabel.text = ""
        addTimeLabel.text = ""
        attributeLabel.text = ""
    }
}
